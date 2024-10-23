<script lang="ts">
  import { Live } from "live_svelte";

  interface Room {
    id: string;
    name: string;
    description: string;
    inserted_at: string;
    updated_at: string;
  }

  export let rooms: Array<Room> = [];

  export let live: Live;
</script>

<div class="flex flex-col">
  <ul>
    {#each rooms as room}
    <li class="border-black border-2 m-2">
      <a data-phx-link="patch" href={`/rooms/${room.id}`}>
        <div>{room.name}</div>
        <div>{room.description}</div>
      </a>
    </li>
    {/each}
  </ul>
</div>