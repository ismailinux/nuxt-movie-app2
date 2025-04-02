<template>
  <div>
    <div class="mb-8">
      <input
        v-model="searchQuery"
        @input="handleSearch"
        type="text"
        placeholder="Search for movies..."
        class="w-full px-4 py-2 rounded-lg bg-gray-800 border border-gray-700 focus:outline-none focus:border-blue-500"
      >
    </div>

    <div v-if="loading" class="text-center">
      <p class="text-xl">Loading...</p>
    </div>

    <div v-else-if="movies.length" class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
      <div v-for="movie in movies" :key="movie.id" class="bg-gray-800 rounded-lg overflow-hidden shadow-lg">
        <NuxtLink :to="'/movies/' + movie.id">
          <img 
            :src="getImageUrl(movie.poster_path)" 
            :alt="movie.title"
            class="w-full h-[400px] object-cover"
          >
          <div class="p-4">
            <h2 class="text-lg font-semibold mb-2">{{ movie.title }}</h2>
            <div class="flex items-center">
              <span class="text-yellow-400">★</span>
              <span class="ml-1">{{ movie.vote_average.toFixed(1) }}</span>
            </div>
          </div>
        </NuxtLink>
      </div>
    </div>

    <div v-else-if="searchQuery" class="text-center">
      <p class="text-xl">No movies found</p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import { useDebounceFn } from '@vueuse/core';

const config = useRuntimeConfig();
const route = useRoute();
const searchQuery = ref('');
const movies = ref([]);
const loading = ref(false);

onMounted(() => {
  const query = route.query.query;
  if (query) {
    searchQuery.value = query;
    handleSearch();
  }
});

const handleSearch = useDebounceFn(async () => {
  if (!searchQuery.value) {
    movies.value = [];
    return;
  }

  loading.value = true;
  try {
    const response = await fetch(
      `${config.public.apiBase}/search/movie?api_key=${config.public.apiKey}&query=${encodeURIComponent(searchQuery.value)}`
    );
    const data = await response.json();
    movies.value = data.results;
  } catch (error) {
    console.error('Error searching movies:', error);
  } finally {
    loading.value = false;
  }
}, 300);

const getImageUrl = (path) => {
  return path ? `${config.public.imageBase}/w500${path}` : '/placeholder.jpg';
};
</script>