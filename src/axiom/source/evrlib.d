module evrlib;

extern(C):
    void evrlib_write(const char *text);
    void evrlib_initgraphic(const char *name);
    void evrlib_text(const char *name, int x, int y, int size, int color);
    bool evrlib_ifwin();
    void evrlib_end();
    void evrlib_draw();
    void evrlib_fidraw();
    void evrlib_cleans(int color);