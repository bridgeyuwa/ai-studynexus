<!DOCTYPE html>
<html>

<head>
    <title>StudyNexus AI Search</title>
    @vite('resources/css/app.css')
    @livewireStyles
</head>

<body class="bg-gray-100 py-8">
    <h1 class="text-6xl text-center mb-5">Study<span class="text-blue-500">Nexus</span></h1>
    {{ $slot }}
    @livewireScripts
</body>

</html>