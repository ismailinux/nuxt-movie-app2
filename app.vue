<template>
  <div class="min-h-screen bg-gray-900 text-white">
    <nav class="bg-gray-800 shadow-lg">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative">
        <div class="flex items-center justify-between h-16">
          <NuxtLink to="/" @click.prevent="turnoffSearch"  class="flex items-center">
            <span class="text-xl font-bold">MovieApp</span>
          </NuxtLink>
          <div class="flex items-center">
            <NuxtLink to="/films" @click.prevent="turnoffSearch" class="px-3 py-2 rounded-md text-sm font-medium hover:bg-gray-700">
              Movies
            </NuxtLink>
            <button
              @click.prevent="toggleSearch"
              class="px-3 py-2 rounded-md text-sm font-medium hover:bg-gray-700"
            >
              Search
            </button>
          </div>
        </div>
        <div
          v-if="isSearchOpen"
          class="absolute top-full left-0 right-0 mx-auto max-w-7xl px-4 py-4 bg-gray-800 shadow-lg transition-all duration-300 ease-in-out z-10 rounded-b-lg"
        >
          <input
            v-model="searchQuery"
            @keydown.enter="navigateToSearch"
            type="text"
            placeholder="Search for movies..."
            class="w-full px-4 py-2 rounded-lg bg-gray-700 border border-gray-600 focus:outline-none focus:border-blue-500 text-white"
            ref="searchInput"
          >
        </div>
      </div>
    </nav>
    <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <NuxtPage />
    </main>
    <Footer class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8"/>
  </div>
</template>

<script setup>
import { ref, onMounted, nextTick } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();
const isSearchOpen = ref(false);
const searchQuery = ref('');
const searchInput = ref(null);

const toggleSearch = () => {
  isSearchOpen.value = !isSearchOpen.value;
  if (isSearchOpen.value) {
    nextTick(() => {
      searchInput.value.focus();
    });
  } else {
    searchQuery.value = '';
  }
};

const turnoffSearch = () =>{
  isSearchOpen.value =false;
}

const navigateToSearch = () => {
  if (searchQuery.value.trim()) {
    router.push(`/search?query=${encodeURIComponent(searchQuery.value)}`);
    isSearchOpen.value = false;
    searchQuery.value = '';
  }
};

onMounted(() => {
  document.addEventListener('click', (event) => {
    const nav = document.querySelector('nav');
    if (isSearchOpen.value && !nav.contains(event.target)) {
      isSearchOpen.value = false;
      searchQuery.value = '';
    }
  });
});
</script>

<style scoped>
.absolute {
  transition: all 0.3s ease-in-out;
}
</style>