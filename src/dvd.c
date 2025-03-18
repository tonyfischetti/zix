// bouncy dvd logo. original code: https://github.com/pythops/bouncinamation
// compile it with gcc bouncinamation.c -o bouncinamation
// compile with the -static flag to make it even more "potato friendly"
// Docker image (RISCV included) https://hub.docker.com/r/defnotgustavom/bouncinamation.c
// Screenshot: https://i.imgur.com/IXxJQiM.png
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <termios.h>
#include <sys/ioctl.h>

#define COLOR_RED     "\x1b[31m"
#define COLOR_GREEN   "\x1b[32m"
#define COLOR_YELLOW  "\x1b[33m"
#define COLOR_BLUE    "\x1b[34m"
#define COLOR_MAGENTA "\x1b[35m"
#define COLOR_CYAN    "\x1b[36m"
#define COLOR_RESET   "\x1b[0m"
#define CLEAR_SCREEN  "\x1b[2J\x1b[H"

typedef struct {
    int x, y, dx, dy;
} Ball;

typedef struct {
    int width, height;
} TerminalSize;

static const char* LOGO[] = {
    "⠀⠀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⡀",
    "⠀⢠⣿⣿⡿⠀⠀⠈⢹⣿⣿⡿⣿⣿⣇⠀⣠⣿⣿⠟⣽⣿⣿⠇⠀⠀⢹⣿⣿⣿",
    "⠀⢸⣿⣿⡇⠀⢀⣠⣾⣿⡿⠃⢹⣿⣿⣶⣿⡿⠋⢰⣿⣿⡿⠀⠀⣠⣼⣿⣿⠏",
    "⠀⣿⣿⣿⣿⣿⣿⠿⠟⠋⠁⠀⠀⢿⣿⣿⠏⠀⠀⢸⣿⣿⣿⣿⣿⡿⠟⠋⠁⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣸⣟⣁⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⣠⣴⣶⣾⣿⣿⣻⡟⣻⣿⢻⣿⡟⣛⢻⣿⡟⣛⣿⡿⣛⣛⢻⣿⣿⣶⣦⣄⡀⠀",
    "⠉⠛⠻⠿⠿⠿⠷⣼⣿⣿⣼⣿⣧⣭⣼⣿⣧⣭⣿⣿⣬⡭⠾⠿⠿⠿⠛⠉⠀"
};

static const int LOGO_HEIGHT = 7;
static const int LOGO_WIDTH = 38;
static const int RIGHT_EDGE_ADJUSTMENT = 8;

static const char* COLORS[] = {
    COLOR_RED, COLOR_GREEN, COLOR_YELLOW,
    COLOR_BLUE, COLOR_MAGENTA, COLOR_CYAN
};
static const int NUM_COLORS = 6;

static inline TerminalSize get_terminal_size() {
    struct winsize ws;
    TerminalSize size = {80, 24};
    if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) != -1) {
        size.width = ws.ws_col;
        size.height = ws.ws_row;
    }
    return size;
}

int main() {
    printf("\x1b[?25l%s", CLEAR_SCREEN);
    
    Ball ball = {1, 1, 1, 1};
    int color_index = 0;
    
    struct termios oldt, newt;
    tcgetattr(STDIN_FILENO, &oldt);
    newt = oldt;
    newt.c_lflag &= ~(ICANON | ECHO);
    newt.c_cc[VMIN] = 0;
    newt.c_cc[VTIME] = 0;
    tcsetattr(STDIN_FILENO, TCSANOW, &newt);
    
    while (1) {
        TerminalSize term = get_terminal_size();
        if (term.width < LOGO_WIDTH || term.height < LOGO_HEIGHT) {
            printf("%s", CLEAR_SCREEN);
            fflush(stdout);
            usleep(100000);
            continue;
        }
        
        int max_x = term.width - LOGO_WIDTH + 1 + RIGHT_EDGE_ADJUSTMENT;
        ball.x += ball.dx;
        ball.y += ball.dy;
        
        if (ball.x > max_x) {
            ball.x = max_x;
            ball.dx = -1;
            color_index = (color_index + 1) % NUM_COLORS;
        } else if (ball.x < 1) {
            ball.x = 1;
            ball.dx = 1;
            color_index = (color_index + 1) % NUM_COLORS;
        }
        
        if (ball.y + LOGO_HEIGHT > term.height) {
            ball.y = term.height - LOGO_HEIGHT;
            ball.dy = -1;
            color_index = (color_index + 1) % NUM_COLORS;
        } else if (ball.y < 1) {
            ball.y = 1;
            ball.dy = 1;
            color_index = (color_index + 1) % NUM_COLORS;
        }
        
        printf("%s", CLEAR_SCREEN);
        for (int i = 0; i < LOGO_HEIGHT; i++) {
            printf("\x1b[%d;%dH%s%s%s", ball.y + i, ball.x, 
                   COLORS[color_index], LOGO[i], COLOR_RESET);
        }
        
        fflush(stdout);
        
        char c;
        if (read(STDIN_FILENO, &c, 1) > 0 && c == 'q') break;
        
        usleep(100000);
    }
    
    printf("%s\x1b[?25h\n", COLOR_RESET);
    tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
    return 0;
}
