#include <stdio.h>
#include "raylib.h"
#include <stdlib.h>

int main(){
    InitWindow(800, 600, "TEST");
    int playerx = 100, playery = 100, enemyx = 200, enemyy = 200;
    int bulletx = 100, bullety, bulletway;
    bool bullet = false, fiapp = false, e22 = false;
    int bulletnum = 0, score = 0;
    while(!WindowShouldClose()){
        printf("X: %d Y:%d\n", playery, playerx);
        printf("EX: %d EY: %d\n", enemyx, enemyy);
        printf("Score: %d\n", score);
        float r = 2.00f;
        BeginDrawing();
        Rectangle p = { playerx, playery, 50, 60 };
        Rectangle e = { enemyx, enemyy, 50, 60 };
        Rectangle e2 = { 300, 500, 50, 60 };
        Rectangle bu = { bulletx, bullety, 10, 10 };
        if (fiapp == true){
            enemyx = rand() % 800;
            enemyy = rand() % 600;
            fiapp = false;
        }
        if (CheckCollisionRecs(e, bu)){
            //ClearBackground(BLACK);
            //DrawText("Enemy get shot!", 350, 300, 15, WHITE);
            fiapp = true;
            score += 1;
        }
        if (CheckCollisionRecs(e2, bu)){
            e22 = true;
            score += 1;
        }
        if (CheckCollisionRecs(p, e2)){
            score = 0;
        }
        if (CheckCollisionRecs(p, e)){
            score = 0;
        }
            bullety = playery;
            if (bullet){
                if (bulletx > 800){
                    bullet = false;
                    bulletx = 100;
                } else {
                    bulletx += 1 * r;
                    bullety = bulletway;
                }
            }
            if (IsKeyPressed(KEY_SPACE) && !(bullet)){
                bullet = true;
                bulletnum += 1;
                bulletway = playery;
            }
            /*
            if ((enemyy >= 600) || (enemyy < 0)){
                enemyy = 200;
            } else if ((enemyx >= 800) || (enemyx < 0)){
                enemyx = 200;
            } else {
                enemyy += 1;
                enemyx -= 1;
            }*/
            if (IsKeyDown(KEY_RIGHT)){
                if((playerx >= 800 - 50) || (playerx < 0)) playerx = 100;
                else playerx += 5 * r;
            } else if (IsKeyDown(KEY_LEFT)){
                if(playerx >= 800 - 50 || playerx < 0) playerx = 100;
                else playerx -= 5 * r;
            } else if (IsKeyDown(KEY_UP)){
                if(playery >= 600 - 50 || playerx < 0) playery = 100;
                else playery -= 5 * r;
            } else if (IsKeyDown(KEY_DOWN)){
                if(playery >= 600 - 50 || playerx < 0) playery = 100;
                else playery += 5 * r;
            }
            ClearBackground(BLACK);
            DrawRectangleRec(p, BLUE);
            if (!fiapp) DrawRectangleRec(e, RED);
            if (!e22) DrawRectangleRec(e2, RED);
            char sc[256];
            sprintf(sc, "Bullet: %d, Score: %d  |  RayTest written by Pouya Mohammadi.", bulletnum, score);
            DrawText(sc, 10, 10, 10, WHITE);
            if (bullet){
                DrawCircle(bulletx, bullety, 10, YELLOW);
            }
        EndDrawing();
    }
    CloseWindow();
    return 0;
}