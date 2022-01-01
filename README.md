# Tilt-Brush-QV-Pen
VRC Prefab

![tilt brush vrc](https://user-images.githubusercontent.com/93958928/147859723-7134eacf-e967-472c-b5fe-c4859e386d1c.gif)

 ** Check off Allow 'Unsafe Code' in the Player tab of the Project Settings

![player settings](https://user-images.githubusercontent.com/93958928/147859545-5fe32b22-21ef-440e-82a9-e13523fb6cbb.PNG)

![VRChat_1920x1080_2022-01-01_02-24-13 659](https://user-images.githubusercontent.com/93958928/147859577-f3d01a11-a4c2-4adf-ab95-df3d3eb74314.png)

note: The VelvetInk WaveForm and Bloom brush shaders have different include paths than the other tilt brush shaders.

#include "Assets/Tilt Brushes by Smew/UnitySDK/Assets/TiltBrush/Assets/Shaders/Include/Brush.cginc"
#include "Assets/Tilt Brushes by Smew/UnitySDK/Assets/ThirdParty/Noise/Shaders/Noise.cginc"

There are more VRC/Quest compatible shaders in here, I just haven't tested them all. I know the Ink splatter and toon works 
but the toon doesn't generate the 3D toon objects like it does in tilt brush at least not yet.

