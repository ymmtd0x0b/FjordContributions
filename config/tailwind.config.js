const defaultTheme = require('tailwindcss/defaultTheme')

const round = (num) =>
  num
    .toFixed(7)
    .replace(/(\.[0-9]+?)0+$/, '$1')
    .replace(/\.0$/, '')
const em = (px, base) => `${round(px / base)}em`

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './node_modules/flowbite/**/*.js'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      typography: {
        DEFAULT: {
          css: {
            h1: {
              fontSize: em(24, 16),
              marginTop: em(48, 24),
              marginBottom: em(24, 24),
              lineHeight: round(32 / 24),
              color: 'var(--tw-prose-headings)',
              fontWeight: '700',
            },
            h2: {
              fontSize: em(20, 16),
              marginTop: em(32, 20),
              marginBottom: em(12, 20),
              lineHeight: round(32 / 20),
              color: 'var(--tw-prose-headings)',
              fontWeight: '600',
            },
            h3: {
              marginTop: em(24, 16),
              marginBottom: em(8, 16),
              lineHeight: round(24 / 16),
              color: 'var(--tw-prose-headings)',
              fontWeight: '600',
            },
          }
        },
      },
      animation: {
        "fade-in-top": "fade-in-top 0.7s cubic-bezier(0.680, -0.550, 0.265, 1.550)    both",
        "fade-out-bottom": "fade-out-bottom 0.7s cubic-bezier(0.680, -0.550, 0.265, 1.550)   reverse both",
        "slide-in-top": "slide-in-top 1.5s cubic-bezier(0.175, 0.885, 0.320, 1.275)    both"
      },
      keyframes: {
        "fade-in-top": {
          "0%": {
            transform: "translateY(-50px)",
            opacity: "0"
          },
          to: {
            transform: "translateY(0)",
            opacity: "1"
          }
        },
        "fade-out-bottom": {
          "0%": {
            transform: "translateY(-50px)",
            opacity: "0"
          },
          to: {
            transform: "translateY(0)",
            opacity: "1"
          }
        },
        "slide-in-top": {
          "0%": {
            transform: "translateY(-150px)",
            opacity: "0"
          },
          to: {
            transform: "translateY(0)",
            opacity: "1"
          }
        }
      },
      colors: {
        "blue": {
          500: "#4f87e1",
          600: "#2569d9"
        }
      }
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries')
  ]
}
