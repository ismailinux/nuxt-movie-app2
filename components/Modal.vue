<template>
  <div
    class="fixed inset-0 bg-black bg-opacity-75 flex items-center justify-center z-50"
    @click.self="$emit('close')"
  >
    <div class="bg-gray-900 p-4 rounded-lg w-full max-w-3xl relative mx-4">
      <button
        @click="$emit('close')"
        class="text-white text-3xl absolute top-2 right-2"
      >
        ×
      </button>
      <iframe
        v-if="trailerUrl"
        :src="trailerUrl"
        frameborder="0"
        allowfullscreen
        class="w-full h-[400px]"
      ></iframe>
      <p v-else class="text-white">No trailer available.</p>
    </div>
  </div>
</template>

<script setup>
defineProps({
  trailerUrl: {
    type: String,
    default: ''
  }
});

defineEmits(['close']);
</script>

<style  scoped>
</style>