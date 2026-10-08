#include <stdio.h>
#include "raylib.h"
#include "graphic.h"

void evrlib_initgraphic(const char *name)
{
    SetTraceLogLevel(LOG_NONE);
    InitWindow(400, 200, name);
}

void evrlib_text(const char *name, int x, int y, int size, int color){
    if (color == 1){
        DrawText(name, x, y, size, BLACK);
    } else if (color == 2){
        DrawText(name, x, y, size, WHITE);
    } else if (color == 3){
        DrawText(name, x, y, size, RED);
    }
}

bool evrlib_ifwin(){
    return WindowShouldClose();
}

void evrlib_draw(){
    BeginDrawing();
}
void evrlib_fidraw(){
    CloseWindow();
}
void evrlib_end(){
    EndDrawing();
}
void evrlib_cleans(int color){
    if (color == 1){
        ClearBackground(BLACK);
    } else if (color == 2){
        ClearBackground(RAYWHITE);
    }
}