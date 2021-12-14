#! /bin/zsh

# if num args != 1
if [ ! $# -eq 1 ]
  then
    echo "only set up for one project currently"
    exit
fi

# Project name
PROJ=$1

# Making directories for the project that we want to make
mkdir $PROJ
cd $PROJ
mkdir src

# have to make src/main.c for cmake to run
touch src/main.c

# Directory where the shell script lives
BASEDIR=$(dirname "$0")

# Copying in basic main function with some imports (smae file as starter)
cp "$BASEDIR"/basicMain.c ./src/main.c

# Quick cmake that creates
cp "$BASEDIR"/CMakeLists.txt .
wait

# Find and replace on key word to project
sed -i -e 's/PROJECT_NAME_VARIABLE/'"$PROJ"'/g' CMakeLists.txt
wait

# basic cmake commands to build project based on CMakeLists.txt
cmake .
wait

cmake --build .
wait

make
wait

# Run project to make sure that it was made
exec $PWD/$PROJ
