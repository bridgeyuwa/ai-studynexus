<div class="max-w-2xl mx-auto bg-white p-6 rounded shadow">
    <!-- Header -->
    <h1 class="text-2xl font-bold mb-4">Search Institution Program Requirements</h1>

    <!-- Livewire form: prevents default form submission and calls the 'submit' method -->
    <form wire:submit.prevent="submit">

        <!-- Institution Dropdown -->
        <div class="mb-4">
            <label class="block font-semibold">Institution</label>
            <select wire:model.live="institution_id" class="w-full border p-2 rounded" required>
                <option value="">Select institution</option>
                @foreach ($institutions as $institution)
                    <option value="{{ $institution->id }}">{{ $institution->name }}</option>
                @endforeach
            </select>
        </div>

        <!-- Level Dropdown (updates based on selected institution) -->
        <div class="mb-4">
            <label class="block font-semibold">Level</label>
            <select wire:model.live="level_id" class="w-full border p-2 rounded" required wire:key="level-{{ $institution_id }}">
                <option value="">Select level</option>
                @foreach ($levels as $level)
                    <option value="{{ $level->id }}">{{ $level->name }}</option>
                @endforeach
            </select>
        </div>

        <!-- Program Dropdown (updates based on selected level) -->
        <div class="mb-4">
            <label class="block font-semibold">Programme</label>
            <select wire:model.live="program_id" class="w-full border p-2 rounded" required wire:key="program-{{ $level_id }}">
                <option value="">Select programme</option>
                @foreach ($programs as $program)
                    <option value="{{ $program->id }}">{{ $program->name }}</option>
                @endforeach
            </select>
        </div>

        <!-- Submit button -->
        <button
            type="submit"
            class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700"
            wire:loading.attr="disabled"  <!-- Disable button while loading -->
        >
            Find Requirements
        </button>

        <!-- Loading indicator while request is being processed -->
        <div wire:loading class="text-sm text-gray-500 mt-2">
            Searching for requirements...
        </div>
    </form>

    <!-- Display result if available -->
    @if ($answer)
        <div class="text-2xl font-bold mb-4">Result</div>

        <!-- Formatted response from LLM -->
        <div class="bg-green-100 text-green-700 p-4 rounded mb-4 whitespace-pre-line">
            {{ $answer }}
        </div>
    @endif
</div>
