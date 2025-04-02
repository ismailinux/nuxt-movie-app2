<template>
  <div v-if="movie" class="movie-detail">
    <div class="flex flex-col md:flex-row gap-8">
      <div class="md:w-1/3">
        <img 
          :src="getImageUrl(movie.poster_path)" 
          :alt="movie.title"
          class="w-full rounded-lg shadow-lg"
        >
      </div>

      <Modal
        v-if="showModal"
        :trailer-url="trailerUrl"
        @close="closeTrailerModal"
      />
      
      <div class="md:w-2/3">
        <h1 class="text-4xl font-bold mb-4">{{ movie.title }}</h1>
        <div class="flex items-center gap-2">
          <div>
            <span
              v-for="star in 5"
              :key="star"
              class="text-yellow-400 text-xl"
            >
              {{ star <= Math.round(movie.vote_average / 2) ? '★' : '☆' }}
            </span>
            <span class="ml-2 text-xl">{{ movie.vote_average.toFixed(1) }}</span>
          </div>
          <span class="text-gray-400">|</span>
          <span>{{ movie.release_date }}</span>
          <span class="text-gray-400">|</span>
          <span class="text-white">{{ formatRuntime(movie.runtime) }}</span>
        </div>
        <p class="text-gray-300 text-lg mb-6">{{ movie.overview }}</p>
        
        <button
          @click="openTrailerModal(movie.id)"
          class="px-4 py-2 bg-red-600 hover:bg-red-700 text-white rounded-lg transition mb-6"
        >
          Watch Trailer
        </button>
        <div class="mb-6">
          <h2 class="text-xl font-semibold mb-2">Genres</h2>
          <div class="flex flex-wrap gap-2">
            <span 
              v-for="genre in movie.genres" 
              :key="genre.id"
              class="px-3 py-1 bg-gray-700 rounded-full text-sm"
            >
              {{ genre.name }}
            </span>
          </div>
        </div>
      </div>
    </div>
  
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router'; 
import Modal from '~/components/Modal.vue'; 

const config = useRuntimeConfig();
const route = useRoute();
const movie = ref(null);
const showModal = ref(false); 
const trailerUrl = ref('');

onMounted(async () => {
  try {
    const detailsResponse = await fetch(
      `${config.public.apiBase}/movie/${route.params.id}?api_key=${config.public.apiKey}`
    );
    const detailsData = await detailsResponse.json();

    const videosResponse = await fetch(
      `${config.public.apiBase}/movie/${route.params.id}/videos?api_key=${config.public.apiKey}`
    );
    const videosData = await videosResponse.json();
    const trailer = videosData.results.find(video => video.type === 'Trailer' && video.site === 'YouTube');

    movie.value = {
      ...detailsData,
      trailerKey: trailer ? trailer.key : null
    };
  } catch (error) {
    console.error('Error fetching movie details:', error);
  }
});

const getImageUrl = (path) => {
  return path ? `${config.public.imageBase}/w500${path}` : '/placeholder.jpg';
};

const formatRuntime = (minutes) => {
  if (!minutes) return 'N/A';
  const hours = Math.floor(minutes / 60);
  const mins = minutes % 60;
  return `${hours}h ${mins}m`;
};

const openTrailerModal = (movieId) => {
  if (movie.value && movie.value.trailerKey) {
    trailerUrl.value = `https://www.youtube.com/embed/${movie.value.trailerKey}?autoplay=1`;
    showModal.value = true;
  } else {
    trailerUrl.value = '';
    showModal.value = true;
  }
};

const closeTrailerModal = () => {
  showModal.value = false;
  trailerUrl.value = '';
};
</script>