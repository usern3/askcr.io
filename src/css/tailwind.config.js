const colors = require('tailwindcss/colors')

module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    colors: {
      gray: colors.coolGray,
      transparent: 'transparent',
      current: 'currentColor',
      black: colors.black,
      white: colors.white,
      red: colors.rose,
      yellow: colors.amber,
      blue: colors.lightBlue,
      pink: colors.pink,
      green: colors.emerald,
      indigo: colors.indigo,
    },
    extend: {
      spacing: {
            128: '32rem',
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
