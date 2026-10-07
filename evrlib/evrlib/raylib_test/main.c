#include <stdio.h>
#include "raylib.h"

int main()
{
    InitWindow(800, 350, "raylib test");
    while(!WindowShouldClose()){
        BeginDrawing();
        ClearBackground(RAYWHITE);
        DrawText("TEST", 300, 200, 30, BLACK);
        EndDrawing();
    }
    CloseWindow();
    return 0;
}