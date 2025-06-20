<!DOCTYPE html>
<html>

<head>
    <title>StudyNexus AI Search</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 py-8">
    <div class="max-w-2xl mx-auto bg-white p-6 rounded shadow">
        <h1 class="text-2xl font-bold mb-4">Search Program Requirements</h1>

        @if (session('answer'))
        <div class="bg-green-100 text-green-700 p-4 rounded mb-4">
            <pre>{{ is_array(session('answer')) ? json_encode(session('answer'), JSON_PRETTY_PRINT) : session('answer') }}</pre>
        </div>
        @endif


        <form method="POST" action="{{ route('ask') }}">
            @csrf

            <div class="mb-4">
                <label class="block font-semibold">Institution</label>
                <select name="institution_id" class="w-full border p-2 rounded" required>
                    @foreach($institutions as $institution)
                    <option value="{{ $institution->id }}">{{ $institution->name }}</option>
                    @endforeach
                </select>
            </div>

            <div class="mb-4">
                <label class="block font-semibold">Program</label>
                <select name="program_id" class="w-full border p-2 rounded" required>
                    @foreach($programs as $program)
                    <option value="{{ $program->id }}">{{ $program->name }}</option>
                    @endforeach
                </select>
            </div>

            <div class="mb-4">
                <label class="block font-semibold">Level</label>
                <select name="level_id" class="w-full border p-2 rounded" required>
                    @foreach($levels as $level)
                    <option value="{{ $level->id }}">{{ $level->name }}</option>
                    @endforeach
                </select>
            </div>

            <button class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700" type="submit">
                Submit
            </button>
        </form>
    </div>
</body>

</html>