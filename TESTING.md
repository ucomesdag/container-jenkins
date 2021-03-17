# Testing

To test the container before publication, run these steps.

1. `container_hash=$(podman build . -q)`.
2. Create the jenkins_home directory `mkdir jenkins_home`.
3. Run: `podman run --privileged --volume ${PWD}/jenkins_home:/var/jenkins_home:z --volume /run/user/1000/podman/podman.sock:/run/user/1000/podman/podman.sock:z --tty --interactive -p 8080:8080 -p 50000:50000 ${container_hash}`.
4. Navigate to `http://localhost:8080`.
