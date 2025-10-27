import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { WardensService } from './wardens.service';
import { Warden } from './entities/warden.entity';

@Controller('wardens')
export class WardensController {
  constructor(private readonly wardensService: WardensService) {}

  @Post()
  create(@Body() createWardenDto: Partial<Warden>) {
    return this.wardensService.create(createWardenDto);
  }

  @Get()
  findAll() {
    return this.wardensService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.wardensService.findOne(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateWardenDto: Partial<Warden>) {
    return this.wardensService.update(id, updateWardenDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.wardensService.remove(id);
  }
}
