# 1. Set up

First, we can remove in `pom.xml`:

```xml
<dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test</artifactId>
        <scope>test</scope>
</dependency>
```
Then, we remove file in `TodoappAppplicationTests` in `test/../todoapp`.

Next, open file `pom.xml` and add ` <version>1.18.38</version>` after `<dependencies>`:
```xml
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.38</version>
    <optional>true</optional>
</dependency>
```

```xml

<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <configuration>
        <annotationProcessorPaths>
            <path>
                <groupId>org.projectlombok</groupId>
                <artifactId>lombok</artifactId>
                <version>1.18.38</version>
            </path>
        </annotationProcessorPaths>
    </configuration>
</plugin>
```
After all, Reaload maven or `Add as Maven Project` (if dont have reload).

Next step, we change file `application.properties`:

```agsl
spring.datasource.url=jdbc:mysql://localhost:3306/<yourdb>
spring.datasource.username=<yourusername>
spring.datasource.password=<youropassword>

spring.jpa.hibernate.ddl-auto=update

spring.jpa.show-sql=true
```
# 2. Create `index.html`
in `src/main/resources/templates`
# 3. Create Controller
in `src/main/java/..`

click setting/build../compiler/ and click `Build project automatically`


