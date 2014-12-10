docker-gource
=============

[Docker](https://www.docker.com) container that has the capability to generate [Gource](https://code.google.com/p/gource) videos in a headless environment.  

# Building
> docker build -t taivokasper/gource .  

# Running
> docker run -it --rm --name gource \  
>     -v REPO_ROOT:/repoRoot \  
>     -v RESULTS_FOLDER:/results \  
>     -v AVATARS_FOLDER:/avatars \  
>     --env TITLE="My overridden title text" \  
>     taivokasper/gource

If you want repository usernames to be replaced with images then put images to avatars folder.  
Name for the avatar image must match the username (e.g taivokasper.png).  
