// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2024-04-03',
  devtools: { enabled: false },
  pages: true,
  modules: ['@nuxtjs/tailwindcss'],
  runtimeConfig: {
    public: {
      apiBase: 'https://api.themoviedb.org/3',
      apiKey: process.env.TMDB_API_KEY,
      imageBase: 'https://image.tmdb.org/t/p'
    }
  }
})