plugins {
    id("java")
    id("war")
    id("checkstyle")
}

group = "ru.astrosoup"
version = "1.0-SNAPSHOT"

checkstyle {
    toolVersion = "11.0.1"
    configFile = file("checkstyle.xml")
    isIgnoreFailures = false
}

repositories {
    mavenCentral()
}

dependencies {
    compileOnly("org.projectlombok:lombok:1.18.42")
    annotationProcessor("org.projectlombok:lombok:1.18.42")
    compileOnly("jakarta.servlet:jakarta.servlet-api:5.0.0")
    testImplementation(platform("org.junit:junit-bom:5.10.0"))
    testImplementation("org.junit.jupiter:junit-jupiter")
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}
war {}

tasks.test {
    useJUnitPlatform()
}