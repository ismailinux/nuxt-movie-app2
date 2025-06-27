<template>
  <div class="bg-gray-900 text-white min-h-screen p-4 md:p-8">
    <!-- Hero Carousel Skeleton -->
    <div class="w-full h-[50vh] sm:h-[60vh] md:h-[70vh] max-h-[500px] mb-8 rounded-lg bg-gray-800 relative overflow-hidden animate-pulse">
      <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-700 to-transparent shimmer"></div>
      
      <!-- Skeleton content overlay -->
      <div class="absolute bottom-0 left-0 p-4 sm:p-6 text-white w-full">
        <!-- Title skeleton -->
        <div class="h-6 sm:h-8 md:h-10 bg-gray-700 rounded mb-2 md:mb-4 w-3/4 relative overflow-hidden">
          <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
        </div>
        
        <!-- Description skeleton - hidden on mobile like original -->
        <div class="hidden md:block space-y-2 mb-2 md:mb-4 w-full lg:w-1/2">
          <div class="h-4 bg-gray-700 rounded relative overflow-hidden">
            <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
          </div>
          <div class="h-4 bg-gray-700 rounded w-4/5 relative overflow-hidden">
            <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
          </div>
        </div>

        <!-- Button skeleton -->
        <div class="w-32 h-8 sm:h-10 bg-gray-700 rounded-lg mb-2 md:mb-4 relative overflow-hidden">
          <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
        </div>

        <!-- Rating and info skeleton -->
        <div class="flex items-center gap-2 sm:gap-3 flex-wrap">
          <!-- Stars skeleton -->
          <div class="flex gap-1">
            <div v-for="star in 5" :key="star" class="w-4 h-4 sm:w-5 sm:h-5 bg-gray-700 rounded relative overflow-hidden">
              <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
            </div>
          </div>
          <span class="text-gray-400">|</span>
          <div class="w-16 h-4 bg-gray-700 rounded relative overflow-hidden">
            <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
          </div>
          <span class="text-gray-400">|</span>
          <div class="w-12 h-4 bg-gray-700 rounded relative overflow-hidden">
            <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
          </div>
          <span class="text-gray-400">|</span>
          <div class="w-14 h-4 bg-gray-700 rounded relative overflow-hidden">
            <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
          </div>
        </div>
      </div>

      <!-- Pagination dots skeleton -->
      <div class="absolute bottom-4 left-1/2 transform -translate-x-1/2 flex gap-2">
        <div v-for="dot in 5" :key="dot" class="w-2 h-2 bg-gray-600 rounded-full"></div>
      </div>
    </div>

    <!-- Popular Movies Title Skeleton -->
    <div class="h-8 sm:h-10 bg-gray-700 rounded mb-8 w-64 relative overflow-hidden animate-pulse">
      <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
    </div>

    <!-- Movies Grid Skeleton -->
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
      <div
        v-for="movie in 20"
        :key="movie"
        class="bg-gray-800 rounded-lg overflow-hidden shadow-lg animate-pulse"
      >
        <!-- Movie poster skeleton -->
        <div class="w-full h-[300px] sm:h-[400px] bg-gray-700 relative overflow-hidden">
          <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
        </div>
        
        <!-- Movie info skeleton -->
        <div class="p-4 space-y-3">
          <!-- Title skeleton -->
          <div class="h-5 sm:h-6 bg-gray-700 rounded relative overflow-hidden">
            <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
          </div>
          
          <!-- Rating skeleton -->
          <div class="flex items-center gap-2">
            <div class="flex gap-1">
              <div v-for="star in 5" :key="star" class="w-4 h-4 bg-gray-700 rounded relative overflow-hidden">
                <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
              </div>
            </div>
            <div class="w-8 h-4 bg-gray-700 rounded relative overflow-hidden">
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
