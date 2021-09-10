//
//  fromterminal.c
//  dotfiles
//
//  Created by Cameron Monks on 08/29/2021
//  Copyright © 2021 cameronmonks. All rights reserved.
//

#include <stdio.h> 
#include <stdlib.h> 
#include <ctype.h>
#include <string.h>

#include <dirent.h>
#include <sys/stat.h>

#include <termios.h>
#include <unistd.h>

#include <util.h>

#include <sys/ioctl.h>


#define ERROR(errorMsg) \
    fprintf(stderr, "ERROR: " errorMsg " LINE: %d\n", __LINE__)

typedef enum {false, true} bool;

int masterfd;

char * getPathOfProgram(const char * program) {

    char * path = getenv("PATH");
    char * full_path = malloc(1024 * sizeof(char));
    unsigned index = 0;
    while (*path != '\0') {

        if (path[index] == ':' || path[index] == '\0') {
            path += index;
            full_path[index] = '\0';

            full_path = strcat(full_path, "/");
            full_path = strcat(full_path, program);

            struct stat buffer;
            int rc = lstat(full_path, &buffer);
            if (rc != -1) {
                return full_path;
            }

            index = 0;
            if (path[index] == ':') {
                path++;
            }
        } else {
            full_path[index] = path[index];
            index++;
        }
    }

    free(full_path);
    return NULL;
}

bool runInput(const char * program_name, char * arguments[]) {
    char * path = getPathOfProgram(program_name);
    if (path == NULL) return false;

    pid_t pid = fork();
    if (pid == -1) {
        ERROR("fork");
        free(path);
        return false;
    }
    if (pid > 0) {
        free(path);
        return true;
    }

    int fd[2];
    if (pipe(fd) != 0) {
        ERROR("PIPE");
        free(path);
        return false;
    }

    pid = fork();
    if (pid == -1) {
        ERROR("Forking");
        exit(1);
    }

    if (pid == 0) {
        close(fd[0]);
        if (dup2(fd[1], 1) == -1) {
            ERROR("DUP2");
            exit(1);
        }
        if (dup2(fd[1], 2) == -1) {
            ERROR("DUP2");
            exit(1);
        }
        close(fd[1]);
        execv(path, arguments);
        exit(1);
    }

    free(path);
    close(fd[1]);
    dup2(fd[0], 0);

    // fd_set rfds;
    // FD_ZERO(&rfds);
    // FD_SET(masterfd, &rfds);
    // struct timeval tv;
    // tv.tv_sec = 0;
    // tv.tv_usec = 0;


    sleep(2);
    char * line = malloc(1024 * sizeof(char));
    while ((line = fgets(line, 1023 * sizeof(char), stdin)) != NULL) {
        dprintf(masterfd, "%s", line);
        // while (ioctl(fd[0], I_NREAD, &n) == 0 && n > 0) {
        //     sleep(1);
        // }
        // int s = select(1, NULL, &rfds, NULL, &tv);
        // printf("RECIEVED %d %d\n", s, masterfd);
        // while (s != 0) {
        //     sleep(1);
        //     s = select(1, &rfds, NULL, NULL, &tv);
        //     printf("RECIEVED %d\n", s);
        // }
        // printf("Finished\n");
    }

    printf("RUN INPUT END\n");
    dprintf(masterfd, "RUN INPUT END\n");

    close(fd[0]);
    exit(0);
}

bool runProgram(const char * program_name, char * arguments[]) {
    char * path = getPathOfProgram(program_name);
    if (path == NULL) return false;

    struct winsize win = {
        .ws_col = 80, .ws_row = 24,
        .ws_xpixel = 480, .ws_ypixel = 192,
    };

    int outputfd = dup(1);
    int pid = forkpty(&masterfd, NULL, NULL, &win);
    if (pid == 0) {
        dup2(outputfd, 1);
        dup2(outputfd, 2);
        execv(path, arguments);
        printf("PYTHON3 HAS ENDED\n");
        dprintf(outputfd, "PYTHON3 HAS ENDED\n");
        exit(1);
    }

    close(outputfd);

    free(path);

    return true;
}

int main(int argc, char * argv[]) {

    setvbuf(stdin, NULL, _IONBF, 0);
    setbuf(stdin, NULL);
    setvbuf(stdout, NULL, _IONBF, 0);

    if (argc < 4) {
        fprintf(stderr, "ERROR: Incorrect usage. Usage: <%s> <program> [arguments] '|' "
                "<program> [arguments]\n",
                argv[0]);
        return 1;
    }

    int index_of_pipe = 0;
    while (index_of_pipe < argc &&
            strcmp(argv[index_of_pipe], "|") != 0) {
        index_of_pipe++;
    }

    if (index_of_pipe < 2 && index_of_pipe >= argc) {
        fprintf(stderr, "ERROR: Incorrect usage. Usage: <%s> <program> [arguments] '|' "
                "<program> [arguments]\n",
                argv[0]);
        return 1;
    }

    if (!runProgram(argv[index_of_pipe+1], argv+index_of_pipe+1)) {
        fprintf(stderr, "ERROR: Could not find program %s. Usage: <%s> <program> [arguments]\n",
                argv[1], argv[0]);
        return 1;
    }

    argv[index_of_pipe] = NULL;
    if (!runInput(argv[1], argv+1)) {
        fprintf(stderr, "ERROR: Could not find program %s. Usage: <%s> <program> [arguments]\n",
                argv[1], argv[0]);
        return 1;
    }

    char * line = malloc(1024 * sizeof(char));
    while (fgets(line, 1023, stdin) != NULL) {
        dprintf(masterfd, "%s", line);
    }

    free(line);

    return 0;
}

