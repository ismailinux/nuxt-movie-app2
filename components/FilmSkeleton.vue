<template>
  <div class="bg-gray-900 text-white p-4 md:p-8">
    <!-- Title Skeleton -->
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
            <!-- Stars skeleton -->
            <div class="flex gap-1">
              <div v-for="star in 5" :key="star" class="w-4 h-4 bg-gray-700 rounded relative overflow-hidden">
                <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
              </div>
            </div>
            <!-- Rating number skeleton -->
            <div class="w-8 h-4 bg-gray-700 rounded ml-2 sm:ml-3 relative overflow-hidden">
              <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Pagination Skeleton -->
    <!-- <div class="flex justify-center items-center mt-8 space-x-4"> -->
      <!-- Previous button skeleton -->
      <!-- <div class="w-20 h-10 bg-gray-700 rounded-lg relative overflow-hidden animate-pulse">
        <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
      </div> -->

      <!-- Page numbers skeleton -->
      <!-- <div class="flex space-x-2">
        <div
          v-for="page in 5"
          :key="page"
          class="w-10 h-10 bg-gray-700 rounded-lg relative overflow-hidden animate-pulse"
        >
          <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
        </div>
      </div> -->

      <!-- Next button skeleton -->
      <!-- <div class="w-16 h-10 bg-gray-700 rounded-lg relative overflow-hidden animate-pulse">
        <div class="absolute inset-0 bg-gradient-to-r from-transparent via-gray-600 to-transparent shimmer"></div>
      </div> -->
    <!-- </div> -->
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
