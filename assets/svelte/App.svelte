<script lang="ts">
  import type { Live } from "live_svelte";

  export let currentUserEmail: string

  // live contains all exported LiveView methods available to the frontend
  export let live: Live
</script>

<h1>{currentUserEmail}</h1>
