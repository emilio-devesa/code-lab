// Emilio Devesa
// https://emiliodevesa.wordpress.com/2023/07/15/ushell-para-macos/
//
// Target SO: MacOS 13.4.1 (Darwin 22.5.0)
// Compiler: Apple clang version 14.0.3 (clang-1403.0.22.14.1)
//
//  uShell.c
//  uShell
//
//  Created by Emilio Devesa on 8/7/23.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <pwd.h>
#include <uuid/uuid.h>
#include <grp.h>
#include <sys/stat.h>
#include <dirent.h>

#define MAXSTR 2048

//  Counts arguments for input command
int countcmdargs (char *input, char * cmdargs []){
    if ((cmdargs[0]=strtok(input, " \n\t"))==NULL) return 0;
    int i=1;
    while ((cmdargs[i]=strtok(NULL, " \n\t"))!=NULL) i++;
    return i;
}

void printAuth(void){
    printf("Emilio Devesa (https://emiliodevesa.wordpress.com/, 2023)\n");
}

char *cwd(void){
    static char buff[MAXSTR];
    return getcwd(buff, MAXSTR);
}

void pwd(void){
    char *pwd=cwd();
    if (pwd != NULL) printf("%s\n",pwd);
    else perror(pwd);
}

void cd (char *cmdargs[MAXSTR]){
    if (cmdargs[0] != 0){
        if (chdir(cmdargs[0]) == -1) perror(cmdargs[0]);
    }
}

char *getGroup(gid_t g){
    struct group *grp;
    if ((grp=getgrgid(g))==NULL) {
        perror("getgrgid() error");
        return NULL;
    }
    else return grp->gr_name;
}

char *getUser(uid_t u){
    struct passwd *p;
    if ((p=getpwuid(u))==NULL) {
        perror("getpwuid() error");
        return NULL;
    }
    else return p->pw_name;
}

char fileType (mode_t m){
    switch (m & S_IFMT){
        case S_IFSOCK: return 's'; // Socket
        case S_IFLNK:  return 'l'; // Symbolic Link
        case S_IFREG:  return '-'; // Regular File
        case S_IFBLK:  return 'b'; // Block Device
        case S_IFDIR:  return 'd'; // Directory
        case S_IFCHR:  return 'c'; // Char Device
        case S_IFIFO:  return 'p'; // Pipe
        default: return '?';       // Unknown
    }
}

char *fileModeToString (mode_t m){
    char *mode=(char *)malloc(11);
    strcpy (mode,"-----------");
    mode[0]=fileType(m);
    if (m&S_IRUSR) mode[1]='r';  // Owner
    if (m&S_IWUSR) mode[2]='w';
    if (m&S_IXUSR) mode[3]='x';
    if (m&S_IRGRP) mode[4]='r';  // Group
    if (m&S_IWGRP) mode[5]='w';
    if (m&S_IXGRP) mode[6]='x';
    if (m&S_IROTH) mode[7]='r';  // Others
    if (m&S_IWOTH) mode[8]='w';
    if (m&S_IXOTH) mode[9]='x';
    if (m&S_ISVTX) mode[10]='T'; // Stickybit
    return (mode);
}

char *getFileMetadata (char *path, char *name){
    struct stat buf;
    char *file = (char *)malloc(sizeof(char)*MAXSTR);
    char *mode = (char *)malloc(sizeof(char)*MAXSTR);
    char *group = (char *)malloc(sizeof(char)*MAXSTR);
    char *user = (char *)malloc(sizeof(char)*MAXSTR);
    char *metadata = (char *)malloc(sizeof(char)*MAXSTR);
    sprintf (file, "%s/%s", path, name);
    if (stat (file, &buf) != -1){
        mode = fileModeToString(buf.st_mode);
        group = getGroup(buf.st_gid);
        user = getUser(buf.st_uid);
        sprintf(metadata, "%s %2hu %10s %10s %7lld %s\n", mode, buf.st_nlink, group, user, buf.st_size, name);
        return metadata;
    }
    else {
        perror("getFileMetadata() stat\n");
        return NULL;
    }
}

void ls(char *cmdargs[MAXSTR]){
    DIR *dir;
    struct dirent *element;
    char *path = NULL;
    int simple=0; int all=0; int i =0;
    // Check arguments
    if (cmdargs[0] != 0){
        for (i=0;cmdargs[i]!=NULL;i++){
            if (!strcmp(cmdargs[i],"-s")) simple = 1;
            else if (!strcmp(cmdargs[i],"-a")) all = 1;
            else path = cmdargs[i];
        }
        if(path == NULL) path = cwd();
    }
    else path=cwd();
    if ((dir=opendir(path)) == NULL) perror(path);
    else {
        while ((element = readdir(dir)) != NULL){
            if (!all && element->d_name[0]=='.') continue;
            else if(simple) printf("%s\n",element->d_name);
            else printf("%s", getFileMetadata(path,element->d_name));
        }
    }
    closedir(dir);
}

int cmdcall(char *cmdargs[]){
    if (!strcmp(cmdargs[0], "quit")) exit(0);
    else if (!strcmp(cmdargs[0], "exit")) exit(0);
    else if (!strcmp(cmdargs[0], "auth")) printAuth();
    else if (!strcmp(cmdargs[0], "pwd")) pwd();
    else if (!strcmp(cmdargs[0], "cd")) cd(cmdargs+1);
    else if (!strcmp(cmdargs[0], "ls")) ls(cmdargs+1);
    // Add more commands here
    return 0; // Status code
}

int main(int argc, const char * argv[]) {
    char *input = (char *) malloc (sizeof (char) * MAXSTR);
    char *cmdargs[MAXSTR];
    // Shell prompt loop
    while (1){
        printf("\n#-> ");
        fgets(input, MAXSTR, stdin); // Reads input
        if (countcmdargs(input, cmdargs)==0) continue;
        cmdcall(cmdargs);
    }
    return 0;
}
