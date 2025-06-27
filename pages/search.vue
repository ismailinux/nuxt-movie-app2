<template>
  <div class="bg-gray-900 text-white min-h-screen p-4 md:p-8">
    <div class="mb-8">
      <input
        v-model="searchQuery"
        @keyup.enter="triggerSearch"
        type="text"
        placeholder="Search for movies... (Press Enter to search)"
        class="w-full px-4 py-2 rounded-lg bg-gray-800 border border-gray-700 focus:outline-none focus:border-blue-500"
      >
    </div>

    <!-- Show skeleton while loading -->
    <FilmSkeleton v-if="loading" />

    <!-- Show movies if we have results and not loading -->
    <div v-else-if="movies.length" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
      <div v-for="movie in movies" :key="movie.id" class="bg-gray-800 rounded-lg overflow-hidden shadow-lg transition-transform hover:scale-105">
        <NuxtLink :to="'/movies/' + movie.id">
          <img 
            :src="getImageUrl(movie.poster_path)" 
            :alt="movie.title"
            class="w-full h-[400px] object-cover"
          >
          <div class="p-4">
            <h2 class="text-lg font-semibold mb-2 truncate">{{ movie.title }}</h2>
            <div class="flex items-center">
              <span class="text-yellow-400">★</span>
              <span class="ml-1">{{ movie.vote_average.toFixed(1) }}</span>
            </div>
          </div>
        </NuxtLink>
      </div>
    </div>

    <!-- Show no results message -->
    <div v-else-if="searchQuery && !loading && movies.length === 0 && hasSearched" class="text-center py-12">
      <p class="text-xl text-gray-400">No movies found for "{{ searchQuery }}"</p>
      <p class="text-gray-500 mt-2">Try searching with different keywords</p>
    </div>

    <!-- Show initial state when no search has been performed -->
    <div v-else-if="!hasSearched && !loading" class="text-center py-12">
      <p class="text-xl text-gray-400">Press Enter to search for movies...</p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import { useDebounceFn } from '@vueuse/core';
import FilmSkeleton from '../components/FilmSkeleton.vue';
import { useRuntimeConfig } from '#app';

const config = useRuntimeConfig();
const route = useRoute();
const searchQuery = ref('');
const movies = ref([]);
const loading = ref(false);
const hasSearched = ref(false);

const getImageUrl = (path) => {
  return path ? `${config.public.imageBase}/w500${path}` : '/placeholder.svg?height=600&width=400';
};

// Debounced search function - only handles the API call
const debouncedSearch = useDebounceFn(async (query) => {
  try {
    const response = await fetch(
      `${config.public.apiBase}/search/movie?api_key=${config.public.apiKey}&query=${encodeURIComponent(query)}`
    );
    const data = await response.json();
    movies.value = data.results || [];
  } catch (error) {
    console.error('Error searching movies:', error);
    movies.value = [];
  } finally {
    loading.value = false;
  }
}, 500); // 500ms debounce

// Trigger function - only runs when Enter is pressed
const triggerSearch = () => {
  if (!searchQuery.value.trim()) {
    return;
  }

  // Set loading state immediately when Enter is pressed
  loading.value = true;
  hasSearched.value = true;
  
  // Call the debounced search function
  debouncedSearch(searchQuery.value);
};

onMounted(() => {
  const query = route.query.query;
  if (query) {
    searchQuery.value = query;
    triggerSearch();
  }
});
</script>
