<template>
  <div class="movie-detail-skeleton bg-gray-900 text-white p-4 md:p-8 min-h-screen">
    <div class="flex flex-col md:flex-row gap-8">
      <!-- Poster Skeleton -->
      <div class="md:w-1/3">
        <div class="w-full aspect-[2/3] bg-gray-700 rounded-lg shadow-lg animate-pulse relative overflow-hidden">
          <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
        </div>
      </div>
      
      <!-- Movie Details Skeleton -->
      <div class="md:w-2/3 space-y-6">
        <!-- Title Skeleton -->
        <div class="space-y-2">
          <div class="h-8 md:h-10 bg-gray-700 rounded animate-pulse relative overflow-hidden">
            <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
          </div>
          <div class="h-8 md:h-10 bg-gray-700 rounded animate-pulse relative overflow-hidden w-3/4">
            <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
          </div>
        </div>
        
        <!-- Rating and Info Skeleton -->
        <div class="flex items-center gap-2 flex-wrap">
          <div class="flex gap-1">
            <div v-for="star in 5" :key="star" class="w-5 h-5 bg-gray-700 rounded animate-pulse relative overflow-hidden">
              <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
            </div>
          </div>
          <div class="w-8 h-6 bg-gray-700 rounded animate-pulse relative overflow-hidden ml-2">
            <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
          </div>
          <span class="text-gray-400">|</span>
          <div class="w-24 h-6 bg-gray-700 rounded animate-pulse relative overflow-hidden">
            <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
          </div>
          <span class="text-gray-400">|</span>
          <div class="w-16 h-6 bg-gray-700 rounded animate-pulse relative overflow-hidden">
            <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
          </div>
        </div>
        
        <!-- Overview Skeleton -->
        <div class="space-y-2">
          <div v-for="line in 4" :key="line" 
               class="h-5 md:h-6 bg-gray-700 rounded animate-pulse relative overflow-hidden" 
               :class="line === 4 ? 'w-2/3' : 'w-full'">
            <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
          </div>
        </div>
        
        <!-- Trailer Button Skeleton -->
        <div class="w-32 h-10 bg-gray-700 rounded-lg animate-pulse relative overflow-hidden">
          <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
        </div>
        
        <!-- Genres Section Skeleton -->
        <div class="space-y-2">
          <div class="h-6 w-16 bg-gray-700 rounded animate-pulse relative overflow-hidden">
            <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
          </div>
          <div class="flex flex-wrap gap-2">
            <div v-for="genre in 3" :key="genre" 
                 class="h-8 bg-gray-700 rounded-full animate-pulse relative overflow-hidden px-4" 
                 :class="genre === 1 ? 'w-16' : genre === 2 ? 'w-20' : 'w-14'">
              <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
// No script needed for skeleton component
</script>

<style scoped>
.shimmer {
  animation: shimmer 2s infinite;
}

@keyframes shimmer {
  0% {
    transform: translateX(-100%);
  }
  100% {
    transform: translateX(100%);
  }
}
</style>
