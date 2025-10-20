import { Test, TestingModule } from '@nestjs/testing';
import { MealsService } from '../src/meals/meals.service';
import { getRepositoryToken } from '@nestjs/typeorm';
import { MealIntent, MealType, MealIntentValue } from '../src/meals/entities/meal-intent.entity';
import { MealOverride } from '../src/meals/entities/meal-override.entity';

describe('MealsService', () => {
  let service: MealsService;
  let mealIntentRepository: any;
  let mealOverrideRepository: any;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        MealsService,
        {
          provide: getRepositoryToken(MealIntent),
          useValue: {
            create: jest.fn(),
            save: jest.fn(),
            findOne: jest.fn(),
            find: jest.fn(),
          },
        },
        {
          provide: getRepositoryToken(MealOverride),
          useValue: {
            create: jest.fn(),
            save: jest.fn(),
            findOne: jest.fn(),
          },
        },
        {
          provide: getRepositoryToken(require('../src/students/entities/student.entity').Student),
          useValue: {},
        },
        {
          provide: getRepositoryToken(require('../src/hostels/entities/hostel.entity').Hostel),
          useValue: {},
        },
      ],
    }).compile();

    service = module.get<MealsService>(MealsService);
    mealIntentRepository = module.get(getRepositoryToken(MealIntent));
    mealOverrideRepository = module.get(getRepositoryToken(MealOverride));
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should check if meal intents are open', async () => {
    const openDto = {
      date: new Date('2024-01-16'),
    };

    mealIntentRepository.findOne.mockResolvedValue(null); // No existing intents

    const result = await service.openIntents(openDto);
    expect(result).toBeDefined();
    expect(result.isOpen).toBe(true);
    expect(result.date).toEqual(openDto.date);
  });

  it('should set day intents before cutoff', async () => {
    const intentsDto = {
      date: new Date('2024-01-16'),
      intents: {
        BREAKFAST: MealIntentValue.YES,
        LUNCH: MealIntentValue.YES,
        SNACKS: MealIntentValue.NO,
        DINNER: MealIntentValue.YES,
      },
    };

    mealIntentRepository.findOne.mockResolvedValue(null); // No existing intents
    mealIntentRepository.create.mockImplementation((data) => data);
    mealIntentRepository.save.mockResolvedValue({});

    const result = await service.setDayIntents(intentsDto, 'test-student-id');
    expect(result).toBeDefined();
    expect(result.length).toBe(4);
  });

  it('should reject intents after cutoff', async () => {
    const intentsDto = {
      date: new Date('2024-01-15'), // Yesterday
      intents: {
        BREAKFAST: MealIntentValue.YES,
        LUNCH: MealIntentValue.YES,
        SNACKS: MealIntentValue.NO,
        DINNER: MealIntentValue.YES,
      },
    };

    // Mock current time to be after 20:00 IST
    const originalDate = Date;
    global.Date = jest.fn(() => new Date('2024-01-15T21:00:00Z')) as any;

    await expect(service.setDayIntents(intentsDto, 'test-student-id'))
      .rejects.toThrow('Meal intent cutoff has passed');

    global.Date = originalDate;
  });

  it('should get meal forecast', async () => {
    const mockIntents = [
      { meal: MealType.BREAKFAST, value: MealIntentValue.YES },
      { meal: MealType.BREAKFAST, value: MealIntentValue.NO },
      { meal: MealType.LUNCH, value: MealIntentValue.YES },
    ];

    mealIntentRepository.find.mockResolvedValue(mockIntents);
    mealOverrideRepository.findOne.mockResolvedValue(null);

    const result = await service.getForecast(7);
    expect(result).toBeDefined();
    expect(result.forecasts).toBeDefined();
    expect(result.forecasts.length).toBe(7);
  });

  it('should create meal override', async () => {
    const overrideDto = {
      date: new Date('2024-01-16'),
      meal: MealType.BREAKFAST,
      hostelId: 'test-hostel-id',
      delta: 10,
      reason: 'Extra guests',
    };

    mealOverrideRepository.findOne.mockResolvedValue(null); // No existing override
    mealOverrideRepository.create.mockImplementation((data) => data);
    mealOverrideRepository.save.mockResolvedValue({});

    const result = await service.createOverride(overrideDto, 'test-user-id');
    expect(result).toBeDefined();
  });
});
