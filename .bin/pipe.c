//
//  pipe.c
//  dotfiles
//
//  Created by Cameron Monks on 09/01/2021
//  Copyright © 2021 cameronmonks. All rights reserved.
//

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>


// MARK: Message

#define DATA_PATH "/tmp/easypipe.pipe|"
#define SEPERATER "|"
#define NAME_LEN 15
#define MSG_LEN 1023
#define TO_STR(x) #x
#define STR_LEN_FORMAT(x) "%" TO_STR(x) "[^\n|]"
#define LINE_LEN NAME_LEN + MSG_LEN + 3 + 8

#define MESSAGE_FORMAT_LEN \
    STR_LEN_FORMAT(NAME_LEN) SEPERATER \
    "%lu" SEPERATER \
    STR_LEN_FORMAT(MSG_LEN)

#define MESSAGE_FORMAT \
    "%s" SEPERATER "%lu" SEPERATER "%s"

struct message
{
    char * name;
    unsigned long count;
    char * msg;
};

int message_capture(struct message * self, const char * line)
{
    return sscanf(line, MESSAGE_FORMAT_LEN,
            self->name, &self->count, self->msg) >= 3;
}

int message_init(struct message * self, const char * line)
{
    self->name = malloc((NAME_LEN+1) * sizeof(char));
    self->msg = malloc((MSG_LEN+1) * sizeof(char));
    return message_capture(self, line);
}

void message_init2(struct message * self)
{
    self->name = malloc((NAME_LEN+1) * sizeof(char));
    self->msg = malloc((MSG_LEN+1) * sizeof(char));
}

int message_tostr(const struct message * self, char * line)
{
    return sprintf(line, MESSAGE_FORMAT, self->name, self->count, self->msg);
}

void message_deinit(struct message * self)
{
    free(self->name);
    free(self->msg);
}

// MARK: File info

unsigned long file_line_count()
{

    FILE * file = fopen(DATA_PATH, "r");
    if (file == NULL) {
        return 0;
    }

    char * line = malloc((LINE_LEN+3) * sizeof(char));
    unsigned long count = 0;
    while ((line = fgets(line,
        (LINE_LEN+2) * sizeof(char), file)) != NULL) {
        count++;
    }

    fclose(file);
    free(line);

    return count;
}

// MARK: Writer

void message_write(struct message * msg)
{
    char * line = malloc((LINE_LEN+1) * sizeof(char));
    message_tostr(msg, line);

    FILE * file = fopen(DATA_PATH, "a");
    fprintf(file, "%s\n", line);
    fclose(file);
    free(line);
}

int writer(int argc, char * argv[])
{
    char * msg = NULL;
    for (int i = 3; i < argc-1; i++) {
        if (strcmp(argv[i], "-m") == 0) {
            msg = argv[i+1];
        }
    }

    struct message message_struct;
    message_struct.count = file_line_count();
    message_struct.name = argv[2];
    if (msg == NULL) {
        msg = malloc((MSG_LEN+1) * sizeof(char));
        while ((msg = fgets(msg, MSG_LEN * sizeof(char), stdin)) != NULL) {
            message_struct.msg = msg;
            message_write(&message_struct);
            message_struct.count++;
        }
        free(msg);
    } else {
        message_struct.msg = msg;
        message_write(&message_struct);
    }

    return 0;
}

// MARK: Reader

int reader(int argc, char * argv[])
{
    FILE * file = fopen(DATA_PATH, "r");

    struct message msg;
    message_init2(&msg);

    char * line = malloc((LINE_LEN+1) * sizeof(char));

    // Get highestCount
    int highestCount = 0;
    while (fgets(line,
        LINE_LEN * sizeof(char), file) != NULL) {

        if (message_capture(&msg, line) &&
            strcmp(msg.name, argv[2]) == 0 &&
            msg.count > highestCount) {
            highestCount = msg.count;
        }
    }

    // Check for new line
    while (1) {
        fclose(file);
        // fseek(file, 0L, SEEK_SET);
        FILE * file = fopen(DATA_PATH, "r");
        while (fgets(line,
            LINE_LEN * sizeof(char), file) != NULL) {

            if (message_capture(&msg, line) &&
                strcmp(msg.name, argv[2]) == 0 &&
                msg.count > highestCount) {

                highestCount = msg.count;
                printf("%s\n", msg.msg);
            }
        }

        sleep(2);
    }

    fclose(file);
    free(line);
    message_deinit(&msg);

    return 0;
}


#define USAGE "ERROR: Incorect usage. Usage: %s <write/read> <name> [args]\n"

int main(int argc, char *argv[])
{
    setvbuf(stdout, NULL, _IONBF, 0);
    if (argc < 3) {
        fprintf(stderr, USAGE, argv[0]);
        return 1;
    }

    if (strcmp(argv[1], "write") == 0) {
        return writer(argc, argv);
    }
    else if (strcmp(argv[1], "read") == 0) {
        return reader(argc, argv);
    }

    fprintf(stderr, USAGE, argv[0]);
    return 1;
}

