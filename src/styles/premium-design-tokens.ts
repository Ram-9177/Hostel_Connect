/**
 * HostelConnect Premium Design System
 * Professional, solid colors with sophisticated palette
 * No bright/vibrant colors - only premium tones
 */

export const premiumColors = {
  // Primary Brand Colors (Deep Blue - Professional & Trustworthy)
  primary: {
    50: '#EFF6FF',
    100: '#DBEAFE',
    200: '#BFDBFE',
    300: '#93C5FD',
    400: '#60A5FA',
    500: '#3B82F6',  // Main brand color
    600: '#2563EB',
    700: '#1D4ED8',  // Darker, more premium
    800: '#1E40AF',
    900: '#1E3A8A',
  },

  // Secondary Colors (Elegant Purple)
  secondary: {
    50: '#FAF5FF',
    100: '#F3E8FF',
    200: '#E9D5FF',
    300: '#D8B4FE',
    400: '#C084FC',
    500: '#A855F7',  // Accent color
    600: '#9333EA',
    700: '#7E22CE',
    800: '#6B21A8',
    900: '#581C87',
  },

  // Neutral Grays (Sophisticated & Clean)
  neutral: {
    50: '#FAFAFA',
    100: '#F5F5F5',
    200: '#E5E5E5',
    300: '#D4D4D4',
    400: '#A3A3A3',
    500: '#737373',
    600: '#525252',
    700: '#404040',
    800: '#262626',
    900: '#171717',
  },

  // Success (Muted Green - Professional)
  success: {
    50: '#F0FDF4',
    100: '#DCFCE7',
    200: '#BBF7D0',
    300: '#86EFAC',
    400: '#4ADE80',
    500: '#22C55E',
    600: '#16A34A',  // Primary success
    700: '#15803D',
    800: '#166534',
    900: '#14532D',
  },

  // Warning (Elegant Amber)
  warning: {
    50: '#FFFBEB',
    100: '#FEF3C7',
    200: '#FDE68A',
    300: '#FCD34D',
    400: '#FBBF24',
    500: '#F59E0B',
    600: '#D97706',  // Primary warning
    700: '#B45309',
    800: '#92400E',
    900: '#78350F',
  },

  // Error (Sophisticated Red)
  error: {
    50: '#FEF2F2',
    100: '#FEE2E2',
    200: '#FECACA',
    300: '#FCA5A5',
    400: '#F87171',
    500: '#EF4444',
    600: '#DC2626',  // Primary error
    700: '#B91C1C',
    800: '#991B1B',
    900: '#7F1D1D',
  },

  // Info (Calm Cyan)
  info: {
    50: '#ECFEFF',
    100: '#CFFAFE',
    200: '#A5F3FC',
    300: '#67E8F9',
    400: '#22D3EE',
    500: '#06B6D4',
    600: '#0891B2',  // Primary info
    700: '#0E7490',
    800: '#155E75',
    900: '#164E63',
  },
};

export const premiumGradients = {
  // Dashboard Gradients (Subtle & Professional)
  student: 'linear-gradient(135deg, #1E40AF 0%, #3B82F6 100%)',
  warden: 'linear-gradient(135deg, #7E22CE 0%, #A855F7 100%)',
  wardenHead: 'linear-gradient(135deg, #155E75 0%, #06B6D4 100%)',
  admin: 'linear-gradient(135deg, #991B1B 0%, #DC2626 100%)',
  chef: 'linear-gradient(135deg, #B45309 0%, #F59E0B 100%)',
  security: 'linear-gradient(135deg, #166534 0%, #22C55E 100%)',

  // Card Overlays (Frosted Glass Effect)
  cardOverlay: 'linear-gradient(135deg, rgba(255, 255, 255, 0.95) 0%, rgba(255, 255, 255, 0.85) 100%)',
  cardOverlayDark: 'linear-gradient(135deg, rgba(23, 23, 23, 0.95) 0%, rgba(38, 38, 38, 0.85) 100%)',

  // Subtle Backgrounds
  backgroundLight: 'linear-gradient(180deg, #FAFAFA 0%, #F5F5F5 100%)',
  backgroundDark: 'linear-gradient(180deg, #171717 0%, #262626 100%)',
};

export const premiumShadows = {
  sm: '0 1px 2px 0 rgba(0, 0, 0, 0.05)',
  DEFAULT: '0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px -1px rgba(0, 0, 0, 0.1)',
  md: '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -2px rgba(0, 0, 0, 0.1)',
  lg: '0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1)',
  xl: '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1)',
  '2xl': '0 25px 50px -12px rgba(0, 0, 0, 0.25)',
  inner: 'inset 0 2px 4px 0 rgba(0, 0, 0, 0.05)',
  
  // Premium Colored Shadows
  primaryGlow: '0 10px 40px -10px rgba(59, 130, 246, 0.4)',
  secondaryGlow: '0 10px 40px -10px rgba(168, 85, 247, 0.4)',
  successGlow: '0 10px 40px -10px rgba(34, 197, 94, 0.4)',
};

export const premiumSpacing = {
  xs: '0.25rem',    // 4px
  sm: '0.5rem',     // 8px
  md: '1rem',       // 16px
  lg: '1.5rem',     // 24px
  xl: '2rem',       // 32px
  '2xl': '3rem',    // 48px
  '3xl': '4rem',    // 64px
  '4xl': '6rem',    // 96px
};

export const premiumBorderRadius = {
  sm: '0.375rem',   // 6px
  DEFAULT: '0.5rem', // 8px
  md: '0.75rem',    // 12px
  lg: '1rem',       // 16px
  xl: '1.5rem',     // 24px
  '2xl': '2rem',    // 32px
  full: '9999px',   // Circular
};

export const premiumTypography = {
  fontFamily: {
    sans: [
      'Inter',
      '-apple-system',
      'BlinkMacSystemFont',
      'Segoe UI',
      'Roboto',
      'Helvetica Neue',
      'Arial',
      'sans-serif',
    ],
    mono: [
      'JetBrains Mono',
      'Fira Code',
      'Consolas',
      'Monaco',
      'monospace',
    ],
  },
  
  fontSize: {
    xs: ['0.75rem', { lineHeight: '1rem' }],      // 12px
    sm: ['0.875rem', { lineHeight: '1.25rem' }],  // 14px
    base: ['1rem', { lineHeight: '1.5rem' }],     // 16px
    lg: ['1.125rem', { lineHeight: '1.75rem' }],  // 18px
    xl: ['1.25rem', { lineHeight: '1.75rem' }],   // 20px
    '2xl': ['1.5rem', { lineHeight: '2rem' }],    // 24px
    '3xl': ['1.875rem', { lineHeight: '2.25rem' }], // 30px
    '4xl': ['2.25rem', { lineHeight: '2.5rem' }], // 36px
  },

  fontWeight: {
    light: '300',
    normal: '400',
    medium: '500',
    semibold: '600',
    bold: '700',
    extrabold: '800',
  },
};

export const premiumAnimations = {
  // Smooth Transitions
  transition: {
    fast: '150ms cubic-bezier(0.4, 0, 0.2, 1)',
    base: '200ms cubic-bezier(0.4, 0, 0.2, 1)',
    slow: '300ms cubic-bezier(0.4, 0, 0.2, 1)',
    slower: '500ms cubic-bezier(0.4, 0, 0.2, 1)',
  },

  // Framer Motion Variants
  fadeIn: {
    initial: { opacity: 0 },
    animate: { opacity: 1 },
    exit: { opacity: 0 },
    transition: { duration: 0.2 },
  },

  slideUp: {
    initial: { opacity: 0, y: 20 },
    animate: { opacity: 1, y: 0 },
    exit: { opacity: 0, y: -20 },
    transition: { duration: 0.3 },
  },

  scaleIn: {
    initial: { opacity: 0, scale: 0.95 },
    animate: { opacity: 1, scale: 1 },
    exit: { opacity: 0, scale: 0.95 },
    transition: { duration: 0.2 },
  },

  staggerChildren: {
    animate: {
      transition: {
        staggerChildren: 0.1,
      },
    },
  },
};

export const premiumEffects = {
  // Glassmorphism
  glass: {
    background: 'rgba(255, 255, 255, 0.1)',
    backdropFilter: 'blur(10px)',
    border: '1px solid rgba(255, 255, 255, 0.2)',
  },

  glassDark: {
    background: 'rgba(0, 0, 0, 0.2)',
    backdropFilter: 'blur(10px)',
    border: '1px solid rgba(255, 255, 255, 0.1)',
  },

  // Neumorphism (Soft UI)
  neumorphLight: {
    background: '#F5F5F5',
    boxShadow: '8px 8px 16px #D4D4D4, -8px -8px 16px #FFFFFF',
  },

  neumorphDark: {
    background: '#262626',
    boxShadow: '8px 8px 16px #171717, -8px -8px 16px #404040',
  },

  // Hover Effects
  hoverScale: {
    transform: 'scale(1.02)',
    transition: 'transform 200ms ease-in-out',
  },

  hoverShadow: {
    boxShadow: '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1)',
    transition: 'box-shadow 200ms ease-in-out',
  },
};

// Role-based Color Mapping
export const roleColors = {
  STUDENT: {
    primary: premiumColors.primary[700],
    secondary: premiumColors.primary[500],
    gradient: premiumGradients.student,
    glow: premiumShadows.primaryGlow,
  },
  WARDEN: {
    primary: premiumColors.secondary[700],
    secondary: premiumColors.secondary[500],
    gradient: premiumGradients.warden,
    glow: premiumShadows.secondaryGlow,
  },
  WARDEN_HEAD: {
    primary: premiumColors.info[700],
    secondary: premiumColors.info[500],
    gradient: premiumGradients.wardenHead,
    glow: '0 10px 40px -10px rgba(6, 182, 212, 0.4)',
  },
  ADMIN: {
    primary: premiumColors.error[700],
    secondary: premiumColors.error[500],
    gradient: premiumGradients.admin,
    glow: '0 10px 40px -10px rgba(220, 38, 38, 0.4)',
  },
  CHEF: {
    primary: premiumColors.warning[700],
    secondary: premiumColors.warning[500],
    gradient: premiumGradients.chef,
    glow: '0 10px 40px -10px rgba(245, 158, 11, 0.4)',
  },
  SECURITY: {
    primary: premiumColors.success[700],
    secondary: premiumColors.success[500],
    gradient: premiumGradients.security,
    glow: premiumShadows.successGlow,
  },
};

// Component Variants
export const cardVariants = {
  elevated: {
    className: 'bg-white dark:bg-neutral-800 rounded-xl shadow-lg hover:shadow-xl transition-shadow',
  },
  flat: {
    className: 'bg-white dark:bg-neutral-800 rounded-xl border border-neutral-200 dark:border-neutral-700',
  },
  glass: {
    className: 'backdrop-blur-lg bg-white/80 dark:bg-neutral-800/80 rounded-xl border border-white/20',
  },
  premium: {
    className: 'bg-gradient-to-br from-white to-neutral-50 dark:from-neutral-800 dark:to-neutral-900 rounded-2xl shadow-2xl border border-neutral-100 dark:border-neutral-700',
  },
};

export const buttonVariants = {
  primary: {
    className: 'bg-primary-700 hover:bg-primary-800 text-white font-semibold rounded-lg shadow-md hover:shadow-lg transition-all',
  },
  secondary: {
    className: 'bg-neutral-100 hover:bg-neutral-200 dark:bg-neutral-800 dark:hover:bg-neutral-700 text-neutral-900 dark:text-neutral-100 font-semibold rounded-lg transition-all',
  },
  ghost: {
    className: 'hover:bg-neutral-100 dark:hover:bg-neutral-800 text-neutral-700 dark:text-neutral-300 font-medium rounded-lg transition-all',
  },
  premium: {
    className: 'bg-gradient-to-r from-primary-600 to-secondary-600 hover:from-primary-700 hover:to-secondary-700 text-white font-bold rounded-xl shadow-lg hover:shadow-2xl transition-all transform hover:scale-105',
  },
};

export default {
  colors: premiumColors,
  gradients: premiumGradients,
  shadows: premiumShadows,
  spacing: premiumSpacing,
  borderRadius: premiumBorderRadius,
  typography: premiumTypography,
  animations: premiumAnimations,
  effects: premiumEffects,
  roleColors,
  cardVariants,
  buttonVariants,
};
