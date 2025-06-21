<!DOCTYPE html>
<html>

<head>
    <title>StudyNexus AI Search</title>

    <!-- Include compiled Tailwind CSS via Vite -->
    @vite('resources/css/app.css')

    <!-- Include Livewire styles -->
    @livewireStyles
</head>

<body class="bg-gray-100 py-8">
    <!-- Main heading for the app -->
    <h1 class="text-6xl text-center mb-5">
        Study<span class="text-blue-500">Nexus</span>
    </h1>

    <!-- This is where Livewire component content will be injected -->
    {{ $slot }}

    <!-- Include Livewire scripts -->
    @livewireScripts
</body>

</html>
