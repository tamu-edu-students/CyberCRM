const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      colors: {
        maroon: {
          800: '#500000', // Texas A&M maroon color hex
        },
      },
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      keyframes: {
        expand: {
          '0%': {
            opacity: 0,
            transform: 'scale(0.5)',
          },
          '100%': {
            opacity: 1,
            transform: 'scale(1)',
          },
        },
        close: {
          '0%': {
            opacity: 1,
            transform: 'scale(1)',
          },
          '100%': {
            opacity: 0,
            transform: 'scale(0.5)',
          },
        },
      },
      animation: {
        expand: 'expand 0.25s ease-out forwards',
        close: 'close 0.25s ease-out forwards',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
