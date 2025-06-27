<template>
  <!-- Show skeleton while loading -->
    <FilmSkeleton v-if="loading" />
    <div v-else>
      <h1 class="text-2xl sm:text-4xl font-bold mb-8">Popular Movies</h1>
      <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
        <div
          v-for="movie in movies"
          :key="movie.id"
          class="bg-gray-800 rounded-lg overflow-hidden shadow-lg transition-transform hover:scale-105"
        >
          <NuxtLink :to="'/movies/' + movie.id">
            <img
              :src="getImageUrl(movie.poster_path)"
              :alt="movie.title"
              class="w-full h-[300px] sm:h-[400px] object-cover"
            >
            <div class="p-4">
              <h2 class="text-base sm:text-lg font-semibold mb-2 truncate">{{ movie.title }}</h2>
              <div class="flex items-center">
                <span
                  v-for="star in 5"
                  :key="star"
                  class="text-yellow-400 text-sm sm:text-base"
                >
                  {{ star <= Math.round(movie.vote_average / 2) ? '★' : '☆' }}
                </span>
                <span class="ml-2 sm:ml-3 text-sm sm:text-base">{{ movie.vote_average.toFixed(1) }}</span>
              </div>
            </div>
          </NuxtLink>
        </div>
      </div>
  
      <div class="flex justify-center items-center mt-8 space-x-4">
        <button
          @click="previousPage"
          :disabled="currentPage === 1"
          class="px-4 py-2 bg-gray-700 text-white rounded-lg hover:bg-gray-600 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
        >
          Previous
        </button>
  
        <div class="flex space-x-2">
          <button
            v-for="page in displayedPages"
            :key="page"
            @click="goToPage(page)"
            :class="[
              'w-10 h-10 flex items-center justify-center rounded-lg transition-colors',
              currentPage === page 
                ? 'bg-gray-600 text-white' 
                : 'bg-gray-800 text-white hover:bg-gray-700'
            ]"
          >
            {{ page }}
          </button>
        </div>
  
        <button
          @click="nextPage"
          :disabled="currentPage === totalPages"
          class="px-4 py-2 bg-gray-700 text-white rounded-lg hover:bg-gray-600 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
        >
          Next
        </button>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted, computed } from 'vue';
  import FilmSkeleton from '../components/FilmSkeleton.vue';
  
  const config = useRuntimeConfig();
  const movies = ref([]);
  const currentPage = ref(1);
  const totalPages = ref(1);
  const loading = ref(true);

  
  const fetchMovies = async (page) => {
    try {
      loading.value = true;

      const response = await fetch(
        `${config.public.apiBase}/movie/popular?api_key=${config.public.apiKey}&page=${page}`
      );
      const data = await response.json();
      movies.value = data.results;
      totalPages.value = data.total_pages;
      currentPage.value = page;
    } catch (error) {
      console.error('Error fetching movies:', error);
    } finally {
    loading.value = false;
  }
  };
  
  onMounted(() => {
    fetchMovies(1);
  });
  
  const nextPage = () => {
    if (currentPage.value < totalPages.value) {
      fetchMovies(currentPage.value + 1);
    }
  };
  
  const previousPage = () => {
    if (currentPage.value > 1) {
      fetchMovies(currentPage.value - 1);
    }
  };
  
  const goToPage = (page) => {
    if (page >= 1 && page <= totalPages.value) {
      fetchMovies(page);
    }
  };
  
  const displayedPages = computed(() => {
    const pages = [];
    const maxPagesToShow = 5;
    let startPage = Math.max(1, currentPage.value - Math.floor(maxPagesToShow / 2));
    let endPage = startPage + maxPagesToShow - 1;
  
    if (endPage > totalPages.value) {
      endPage = totalPages.value;
      startPage = Math.max(1, endPage - maxPagesToShow + 1);
    }
  
    for (let i = startPage; i <= endPage; i++) {
      pages.push(i);
    }
    return pages;
  });
  
  const getImageUrl = (path) => {
    return path ? `${config.public.imageBase}/w500${path}` : '/placeholder.jpg';
  };
  </script>