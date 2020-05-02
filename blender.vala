
/* Copyright (c) Anton "Vuvk" Shcherbatykh, 2020. */
/* Original: Copyright (c) Mark J. Kilgard, 1994. */

/* Based on https://www.opengl.org/archives/resources/code/samples/glut_examples/examples/examples.html */

/* This program is freely distributable without licensing fees
   and is provided without guarantee or warrantee expressed or
   implied. This program is -not- in the public domain. */

/* blender renders two spinning icosahedrons (red and green).
   The blending factors for the two icosahedrons vary sinusoidally
   and slightly out of phase.  blender also renders two lines of
   text in a stroke font: one line antialiased, the other not.  */

using GL;
using GLU;
using GLUT;

class GLTest {
    static GLfloat[] light0_ambient  = { 0.2f,  0.2f, 0.2f, 1.0f};
    static GLfloat[] light0_diffuse  = { 0.0f,  0.0f, 0.0f, 1.0f};
    static GLfloat[] light1_diffuse  = { 1.0f,  0.0f, 0.0f, 1.0f};
    static GLfloat[] light1_position = { 1.0f,  1.0f, 1.0f, 0.0f};
    static GLfloat[] light2_diffuse  = { 0.0f,  1.0f, 0.0f, 1.0f};
    static GLfloat[] light2_position = {-1.0f, -1.0f, 1.0f, 0.0f};
    static float s = 0.0f;
    static GLfloat angle1 = 0.0f;
    static GLfloat angle2 = 0.0f;

    static GLfloat[] amb = { 0.4f, 0.4f, 0.4f, 0.0f };
    static GLfloat[] dif = { 1.0f, 1.0f, 1.0f, 0.0f };

    static void print_string(GLfloat x, GLfloat y, string text) {
        glPushMatrix();
        glTranslatef(x, y, 0);
        foreach (uint8 p in text.data) {
            glutStrokeCharacter((void*)GLUT_STROKE_ROMAN, p);
        }
        glPopMatrix();
    }

    static void display() {

        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        /*glEnable(GL_LIGHT1);
        glDisable(GL_LIGHT2);
        amb[3] = dif[3] = Math.cosf(s) / 2.0f + 0.5f;
        glMaterialfv(GL_FRONT, GL_AMBIENT, amb);
        glMaterialfv(GL_FRONT, GL_DIFFUSE, dif);*/

        glPushMatrix();
        glTranslatef(-0.3f, -0.3f, 0.0f);
        glRotatef(angle1, 1.0f, 5.0f, 0.0f);
        glutSolidIcosahedron();
        //glCallList(1);        /* render ico display list */
        glPopMatrix();

        glClear(GL_DEPTH_BUFFER_BIT);
        /*glEnable(GL_LIGHT2);
        glDisable(GL_LIGHT1);
        amb[3] = dif[3] = 0.5f - Math.cosf(s * 0.95f) / 2.0f;
        glMaterialfv(GL_FRONT, GL_AMBIENT, amb);
        glMaterialfv(GL_FRONT, GL_DIFFUSE, dif);*/

        glPushMatrix();
        glTranslatef(0.3f, 0.3f, 0.0f);
        glRotatef(angle2, 1.0f, 0.0f, 5.0f);
        glutSolidIcosahedron();
        //glCallList(1);        /* render ico display list */
        glPopMatrix();

        glPushAttrib(GL_ENABLE_BIT);
        glDisable(GL_DEPTH_TEST);
        glDisable(GL_LIGHTING);
        glMatrixMode(GL_PROJECTION);
        glPushMatrix();
        glLoadIdentity();
        gluOrtho2D(0, 1500, 0, 1500);
        glMatrixMode(GL_MODELVIEW);
        glPushMatrix();
        glLoadIdentity();
        /* Rotate text slightly to help show jaggies. */
        glRotatef(4f, 0.0f, 0.0f, 1.0f);
        print_string(200, 225, "This is antialiased.");
        glDisable(GL_LINE_SMOOTH);
        glDisable(GL_BLEND);
        print_string(160, 100, "This text is not.");
        glPopMatrix();
        glMatrixMode(GL_PROJECTION);
        glPopMatrix();
        glPopAttrib();
        glMatrixMode(GL_MODELVIEW);

        glutSwapBuffers();
    }

    static void idle() {
        angle1 = (GLfloat) Math.fmod(angle1 + 0.8f, 360.0f);
        angle2 = (GLfloat) Math.fmod(angle2 + 1.1f, 360.0f);
        s += 0.05f;
        glutPostRedisplay();
    }

    static void visible(int vis) {
        if (vis == GLUT_VISIBLE)
            glutIdleFunc(idle);
        else
            glutIdleFunc(null);
    }

    public static int main(string[] args) {
        int argc = args.length;
        glutInit(ref argc, args);

        glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
        glutCreateWindow("blender");
        glutDisplayFunc(display);
        glutVisibilityFunc(visible);

        //glNewList(1, GL_COMPILE);  /* create ico display list */
        //glutSolidIcosahedron();
        //glEndList();

        glEnable(GL_LIGHTING);
        glEnable(GL_LIGHT0);
        /*glLightfv(GL_LIGHT0, GL_AMBIENT, light0_ambient);
        glLightfv(GL_LIGHT0, GL_DIFFUSE, light0_diffuse);
        glLightfv(GL_LIGHT1, GL_DIFFUSE, light1_diffuse);
        glLightfv(GL_LIGHT1, GL_POSITION, light1_position);
        glLightfv(GL_LIGHT2, GL_DIFFUSE, light2_diffuse);
        glLightfv(GL_LIGHT2, GL_POSITION, light2_position);*/
        glEnable(GL_DEPTH_TEST);
        glEnable(GL_CULL_FACE);
        glEnable(GL_BLEND);
        glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        glEnable(GL_LINE_SMOOTH);
        glLineWidth(2.0f);

        glMatrixMode(GL_PROJECTION);
        gluPerspective( /* field of view in degree */ 40.0f,
                        /* aspect ratio */ 1.0f,
                        /* Z near */ 1.0f, /* Z far */ 10.0f);
        glMatrixMode(GL_MODELVIEW);
        gluLookAt(0.0f, 0.0f, 5.0f,  /* eye is at (0,0,5) */
                  0.0f, 0.0f, 0.0f,  /* center is at (0,0,0) */
                  0.0f, 1.0f, 0.0f); /* up is in positive Y direction */
        glTranslatef(0.0f, 0.6f, -1.0f);

        glutMainLoop();
        return 0;             /* ANSI C requires main to return int. */
    }

}
