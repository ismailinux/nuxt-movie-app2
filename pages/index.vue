<template>
  <div>
    <ClientOnly>
      <Swiper
        :modules="[Navigation, Pagination, Autoplay]"
        :navigation="true"
        :pagination="{ clickable: true }"
        :autoplay="{ delay: 60000 }"
        class="w-full h-[50vh] sm:h-[60vh] md:h-[70vh] max-h-[500px] mb-8 rounded-lg"
      >
        <SwiperSlide v-for="movie in featuredMovies" :key="movie.id">
          <div class="relative w-full h-full bg-black">
            <img
              :src="getBackdropUrl(movie.backdrop_path)"
              :alt="movie.title"
              class="w-full h-full object-contain md:object-cover lg:object-cover"
            >
            <div class="absolute inset-0 bg-gradient-to-t lg:bg-gradient-to-r from-black to-transparent"></div>
            <div class="absolute bottom-0 left-0 p-4 sm:p-6 text-white w-full">
              <h2 class="text-xl sm:text-2xl md:text-4xl font-bold truncate">{{ movie.title }}</h2>
              <p class="text-xs md:text-base hidden md:block w-full sm:w-1/2 md:w-full lg:w-1/2 mt-2 md:mt-4 line-clamp-2">
               {{ movie.overview }}
              </p>

              <button
                @click="openTrailerModal(movie.id)"
                class="mt-2 md:mt-4 px-3 py-1 sm:px-4 sm:py-2 bg-red-600 hover:bg-red-700 text-white rounded-lg transition text-sm sm:text-base"
              >
                Watch Trailer
              </button>
              <div class="flex items-center gap-2 sm:gap-3 mt-2 md:mt-4 flex-wrap">
                <div class="flex">
                  <span
                    v-for="star in 5"
                    :key="star"
                    class="text-yellow-400 text-lg sm:text-xl"
                  >
                    {{ star <= Math.round(movie.vote_average / 2) ? '★' : '☆' }}
                  </span>
                </div>
                <span class="text-gray-400">|</span>
                <span class="text-sm sm:text-base">{{ movie.vote_count }} Reviews</span>
                <span class="text-gray-400">|</span>
                <span class="text-sm sm:text-base">{{ new Date(movie.release_date).getFullYear() }}</span>
                <span class="text-gray-400">|</span>
                <span class="text-sm sm:text-base">{{ formatRuntime(movie.runtime) }}</span>
              </div>
            </div>
          </div>
        </SwiperSlide>
      </Swiper>
    </ClientOnly>

    <Modal
      v-if="showModal"
      :trailer-url="trailerUrl"
      @close="closeTrailerModal"
    />

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
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { Swiper, SwiperSlide } from 'swiper/vue';
import { Navigation, Pagination, Autoplay } from 'swiper/modules';
import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/pagination';
import Modal from '~/components/Modal.vue';

const config = useRuntimeConfig();

const movies = ref([]);
const featuredMovies = ref([]);
const showModal = ref(false);
const trailerUrl = ref('');

onMounted(async () => {
  try {
    const [popularResponse, nowPlayingResponse] = await Promise.all([
      fetch(`${config.public.apiBase}/movie/popular?api_key=${config.public.apiKey}`),
      fetch(`${config.public.apiBase}/movie/now_playing?api_key=${config.public.apiKey}`),
    ]);

    const popularData = await popularResponse.json();
    const nowPlayingData = await nowPlayingResponse.json();

    movies.value = popularData.results;

    const detailedMovies = await Promise.all(
      nowPlayingData.results.slice(0, 5).map(async (movie) => {
        const detailsResponse = await fetch(
          `${config.public.apiBase}/movie/${movie.id}?api_key=${config.public.apiKey}`
        );
        const videosResponse = await fetch(
          `${config.public.apiBase}/movie/${movie.id}/videos?api_key=${config.public.apiKey}`
        );
        const detailsData = await detailsResponse.json();
        const videosData = await videosResponse.json();
        const trailer = videosData.results.find(video => video.type === 'Trailer' && video.site === 'YouTube');
        return {
          ...movie,
          runtime: detailsData.runtime,
          trailerKey: trailer ? trailer.key : null,
        };
      })
    );

    featuredMovies.value = detailedMovies;
  } catch (error) {
    console.error('Error fetching movies:', error);
  }
});

const getImageUrl = (path) => {
  return path ? `${config.public.imageBase}/w500${path}` : '/placeholder.jpg';
};

const getBackdropUrl = (path) => {
  return path ? `${config.public.imageBase}/w1280${path}` : '/placeholder.jpg';
};

const formatRuntime = (minutes) => {
  if (!minutes) return 'N/A';
  const hours = Math.floor(minutes / 60);
  const mins = minutes % 60;
  return `${hours}h ${mins}m`;
};

const openTrailerModal = (movieId) => {
  const movie = featuredMovies.value.find(m => m.id === movieId);
  if (movie && movie.trailerKey) {
    trailerUrl.value = `https://www.youtube.com/embed/${movie.trailerKey}?autoplay=1`;
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

<style >
.swiper .swiper-button-prev,
.swiper .swiper-button-next {
  opacity: 0;
  transition: opacity 0.3s ease-in-out;
  pointer-events: none;
}

.swiper:hover .swiper-button-prev,
.swiper:hover .swiper-button-next {
  opacity: 1;
  pointer-events: auto;
}

@media (max-width: 639px) {
  .swiper .swiper-button-prev,
  .swiper .swiper-button-next {
    display: none !important;
  }
}
</style>