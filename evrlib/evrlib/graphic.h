#ifndef GRAPHIC_H
#define GRAPHIC_H

void evrlib_initgraphic(const char *name);
void evrlib_text(const char *name, int x, int y, int size, int color);
void evrlib_draw();
bool evrlib_ifwin();
void evrlib_fidraw();
void evrlib_end();
void evrlib_clears(int color);

#endif