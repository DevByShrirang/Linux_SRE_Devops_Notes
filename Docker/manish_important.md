virtualization-
 running multiple virtual machines on same physical machine.
 single laptop with software (virtualbox /vmware) --> we will get windows in one virtual machine, ubuntu in another
 run multiple OS on one machine which will save hardware cost, easily test and develop different environments 

 Difference between ARG & ENV.
 ARG - argument is used to define variables that are available only during image build time. it cannot be accessed after the container is running.
 ENV -  ENV defines environment variable that persist in the final image and can be accessed both during build and runtime.

 **Difference between RUN & CMD**
 RUN executes shell commands inside the image during the build stage. It’s used to install dependencies or set up the environment, and each RUN instruction creates a new image layer.

ADD is used to copy files from the local context or even download files from a remote URL into the image. However, the best practice is to use COPY for local files and use RUN curl or RUN wget for remote downloads to keep Dockerfiles clean and predictable.
In my dockerfile.
RUN mvn dependency: resolve  - Resolving dependencies at build time. docker caching layer created to to minimize build time.
RUN mvn clean package  - compiling the java code and packaging it into JAR file.
RUN useradd -ms /bin/bash appuser - Non-root user created to avoid container to run as root.

CMD - CMD is the default command to run when a container starts from the image. this command will run every time the container is started , restarted, recreated, -because its container main process.

ENTRYPOINT - Both CMD & entrypoint  used to run commands when container starts.
     CMD can be overridden when running a container, CMD can be fully replaced by any args passed in docker run.
     Entrypoint - Treats is value as executable and cannot be overridden easily. entrypoint always run, it is fixed . argument passed at docker run are treated as aditional arguments to ENTRYPOINT.

**TAG immutability in docker**
TAG immutability is best practoce to push docker image with specific tag to avoid conflicts and ambiguilty. we cannot be changed or overwritten tagged docker image.

**use of multi-stage docker builds?**
  In my project, I used a multi-stage Dockerfile. The first stage uses Maven with JDK to build the application and produce a JAR. The second stage uses a lightweight JRE image and only copies the JAR. This makes the final image smaller, more secure, and faster to build, since unnecessary build tools are left out of production.

Benefits

Smaller image size → final runtime image is much lighter (only JRE + JAR).
Security → no compilers or build tools shipped to production.
Faster builds → dependencies are cached via separate RUN mvn dependency:resolve.
Best practice → separation of build & runtime responsibilities.

**what is container in reality**
container is isolated environment that includes application and its dependencies , running on the host os, running instances of docker images is called container.
it shared host kernel , and isolated processes , filesystem and networking.


**Difference between ADD and COPY?**
both are used to copy files but ADD has some extra features.
can download from URL   can extract ".tar" files
use "COPY" for basic file transfer for clarity and performance.


**Can we delete the image from which a container is running?**
No- even with force , docker wont allow this.
Docker prevents deletion of any image that is curently being used by a container- whether that container is running or stopped.


**write dockerfile to start nginx server**
FROM nginx:latest
COPY: ./index.html/usr/share/nginx/html/index.html
EXPOSE 80
CMD ["nginx", "-g", "daemon off"]


**docker vs  VM virtualization**
docker shares the host os kernel  --> VM has its own OS for each instance
docker is lightweight and faster --> VMs are heavier and smaller
docker starts inseconds          --> VMs take minute to boot up.
docker provider process-level isolation --> VMs provide full system isolation.
Docker consumes fewer system resources --> VMs consume more due to full os.
docker containers are highly  portable  --> VMs are less portable.
docker is ideal for microservices and cicd --> VMs are better for full os environments or legacy apps.

**types of docker networking**

Bridge :- Default network
Host :- uses host network directly.
overlay: - cross host netwoorking for swarm
None:- no  network assigned to container
Macvlan:- Assign MAC addresses and appers on physical network.


docker run -d -p host-port:container-port container-name image-name.
docker run -d -p 8080:8080 my-app-service my-app
docker build -t my-app:1.2 .


**virtulization?**
virtulization means running multiple virtual computers on one physical machine. all these VMs having its own cpu, memory, disk.

