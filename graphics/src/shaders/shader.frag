#version 330 core
in vec3 colour;
in float shadow;

out vec4 finalColor;


void main() {
    // For debugging, let's display the pure color without shadow influence
    finalColor = vec4(colour, 1.0);
}