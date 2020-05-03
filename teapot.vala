using GLib;
using GL;
using GLU;
using GLUT;

public enum EColorBack {BLACK, DARKRED, DARKGREEN, DARKBLUE}
public enum EColorDraw {WHITE, LIGHTRED, LIGHTGREEN, LIGHTBLUE}
public enum ESolid {WIRE, SOLID}
public enum EModel {TEAPOT, CUBE, SPHERE, CONE, TORUS, DODECAHEDRON, OCTAHEDRON, TETRAHEDRON, ICOSAHEDRON}
public enum EAxes {AXESNO, AXESSIMPLE}

public struct SRgba {
        public GLdouble R;
        public GLdouble G;
        public GLdouble B;
        public GLdouble A;

        public SRgba (GLdouble r = 0, GLdouble g = 0, GLdouble b = 0, GLdouble a = 1) {
                R = r;
                G = g;
                B = b;
                A = a;
        }
}

public struct SPreferences {
        public SRgba ColorFondo;
        public SRgba ColorDibujo;
        public bool Iluminacion;
        public ESolid Solid;
        public EModel Model;
        public EAxes Axes;
        public bool Animation;

        public SPreferences () {
                ColorFondo = SRgba (0.0f, 0.0f, 0.0f, 1.0f);
                ColorDibujo = SRgba (1.0f, 1.0f, 1.0f, 1.0f);
                Iluminacion = true;
                Solid = ESolid.WIRE;
                Model = EModel.TEAPOT;
                Axes = EAxes.AXESNO;
                Animation = false;
        }
}

public class Example : Object {

        private static GLfloat alpha;
        private static GLfloat beta;
        private static int x0;
        private static int y0;
        private static SPreferences preferences;

        protected static void on_glutDisplayFunc () {

                glClearColor ((GLclampf) preferences.ColorFondo.R,
                                (GLclampf) preferences.ColorFondo.G,
                                (GLclampf) preferences.ColorFondo.B,
                                (GLclampf) preferences.ColorFondo.A);

                glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

                glColor3d (preferences.ColorDibujo.R,
                                preferences.ColorDibujo.G,
                                preferences.ColorDibujo.B);

                glMatrixMode (GL_PROJECTION);
                glLoadIdentity ();
                gluPerspective (20.0f, 1.0f, 1.0f, 10.0f);
                glMatrixMode (GL_MODELVIEW);
                glLoadIdentity ();
                gluLookAt (0.0f, 0.0f, 5.0f,
                                0.0f, 0.0f, 0.0f,
                                0.0f, 1.0f, 0.0f);
                glRotatef (alpha, 1.0f, 0.0f, 0.0f);
                glRotatef (beta, 0.0f, 1.0f, 0.0f);

                if (preferences.Axes == EAxes.AXESSIMPLE) {
                        glBegin (GL_LINES);
                                glVertex3f (0.0f, 0.0f, 0.0f);
                                glVertex3f (0.8f, 0.0f, 0.0f);
                                glVertex3f (0.0f, 0.0f, 0.0f);
                                glVertex3f (0.0f, 0.8f, 0.0f);
                                glVertex3f (0.0f, 0.0f, 0.0f);
                                glVertex3f (0.0f, 0.0f, 0.8f);
                        glEnd ();
                }

                if (preferences.Solid == ESolid.WIRE ) {
                        switch (preferences.Model) {
                        case EModel.TEAPOT:
                                glutWireTeapot (0.5);
                                break;
                        case EModel.CUBE:
                                glutWireCube (0.5);
                                break;
                        case EModel.SPHERE:
                                glutWireSphere (0.5, 40, 40);
                                break;
                        case EModel.CONE:
                                glutWireCone (0.5, 0.8, 40, 40);
                                break;
                        case EModel.TORUS:
                                glutWireTorus (0.2, 0.5, 40, 40);
                                break;
                        case EModel.DODECAHEDRON:
                                glutWireDodecahedron ();
                                break;
                        case EModel.OCTAHEDRON:
                                glutWireOctahedron ();
                                break;
                        case EModel.TETRAHEDRON:
                                glutWireTetrahedron ();
                                break;
                        case EModel.ICOSAHEDRON:
                                glutWireIcosahedron ();
                                break;
                        }
                } else { // ESolid.SOLID
                        switch (preferences.Model) {
                        case EModel.TEAPOT:
                                glutSolidTeapot (0.5);
                                break;
                        case EModel.CUBE:
                                glutSolidCube (0.5);
                                break;
                        case EModel.SPHERE:
                                glutSolidSphere (0.5, 40, 40);
                                break;
                        case EModel.CONE:
                                glutSolidCone (0.5, 0.8, 40, 40);
                                break;
                        case EModel.TORUS:
                                glutSolidTorus (0.2, 0.5, 40, 40);
                                break;
                        case EModel.DODECAHEDRON:
                                glutSolidDodecahedron ();
                                break;
                        case EModel.OCTAHEDRON:
                                glutSolidOctahedron ();
                                break;
                        case EModel.TETRAHEDRON:
                                glutSolidTetrahedron ();
                                break;
                        case EModel.ICOSAHEDRON:
                                glutSolidIcosahedron ();
                                break;
                        }
                }

                glFlush ();
                glutSwapBuffers ();
        }

        protected static void on_glutMouseFunc (int button, int state, int x, int y) {
                if ((button == GLUT_LEFT_BUTTON) & (state == GLUT_DOWN)) {
                        x0 = x;
                        y0 = y;
                }
        }

        protected static void on_glutMotionFunc (int x, int y) {
                alpha = (alpha + (y - y0));
                beta = (beta + (x - x0));
                x0 = x;
                y0 = y;
                glutPostRedisplay();
        }

        protected static void on_glutCreateMenu (int opcion) { }

        protected static void on_glutCreateMenu_EColorBack (int opcion) {
                switch (opcion) {
                case EColorBack.BLACK:
                        preferences.ColorFondo.R = 0.0f;
                        preferences.ColorFondo.G = 0.0f;
                        preferences.ColorFondo.B = 0.0f;
                        break;
                case EColorBack.DARKRED:
                        preferences.ColorFondo.R = 0.25f;
                        preferences.ColorFondo.G = 0.05f;
                        preferences.ColorFondo.B = 0.05f;
                        break;
                case EColorBack.DARKGREEN:
                        preferences.ColorFondo.R = 0.05f;
                        preferences.ColorFondo.G = 0.25f;
                        preferences.ColorFondo.B = 0.05f;
                        break;
                case EColorBack.DARKBLUE:
                        preferences.ColorFondo.R = 0.05f;
                        preferences.ColorFondo.G = 0.05f;
                        preferences.ColorFondo.B = 0.25f;
                        break;
                }
                glutPostRedisplay();
        }

        protected static void on_glutCreateMenu_EColorDraw (int opcion) {
                switch (opcion) {
                case EColorDraw.WHITE:
                        preferences.ColorDibujo.R = 1.0f;
                        preferences.ColorDibujo.G = 1.0f;
                        preferences.ColorDibujo.B = 1.0f;
                        break;
                case EColorDraw.LIGHTRED:
                        preferences.ColorDibujo.R = 0.65f;
                        preferences.ColorDibujo.G = 0.05f;
                        preferences.ColorDibujo.B = 0.05f;
                        break;
                case EColorDraw.LIGHTGREEN:
                        preferences.ColorDibujo.R = 0.05f;
                        preferences.ColorDibujo.G = 0.65f;
                        preferences.ColorDibujo.B = 0.05f;
                        break;
                case EColorDraw.LIGHTBLUE:
                        preferences.ColorDibujo.R = 0.05f;
                        preferences.ColorDibujo.G = 0.05f;
                        preferences.ColorDibujo.B = 0.65f;
                        break;
                }
                glutPostRedisplay();
        }

        protected static void on_glutCreateMenu_ESolid (int opcion) {
                preferences.Solid = (ESolid) opcion;
                glutPostRedisplay();
        }

        protected static void on_glutCreateMenu_EModel (int opcion) {
                preferences.Model = (EModel) opcion;
                glutPostRedisplay();
        }

        protected static void on_glutCreateMenu_EAxes (int opcion) {
                preferences.Axes = (EAxes) opcion;
                glutPostRedisplay();
        }

        protected static void on_glutCreateMenu_Animation (int opcion) {
                switch (opcion) {
                case 0:
                        preferences.Animation = false;
                        break;
                case 1:
                        preferences.Animation = true;
                        glutTimerFunc (20, on_glutTimerFunc, 1);
                        break;
                }
                glutPostRedisplay();
        }

        protected static void on_glutTimerFunc () {
                glutPostRedisplay();
                beta ++;
                if (preferences.Animation == true)
                        glutTimerFunc (20, on_glutTimerFunc, 1);
        }

        protected static void Init_Window (string[] args) {
                glutInit (ref args.length, args);
                glutInitDisplayMode (GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH);
                glutInitWindowSize (400, 400);
                glutInitWindowPosition (100, 100);
                glutCreateWindow ("Glut example");
        }

        protected static void Init_Events () {
                glutDisplayFunc (on_glutDisplayFunc);
                glutMouseFunc (on_glutMouseFunc);
                glutMotionFunc (on_glutMotionFunc);
        }

        protected static void Init_Menu () {
                int menuMain, menuBack, menuDraw, menuSolid, menuModel, menuAxes, menuAnimation;

                menuBack = glutCreateMenu (on_glutCreateMenu_EColorBack);
                glutAddMenuEntry ("Black", EColorBack.BLACK);
                glutAddMenuEntry ("Dark red", EColorBack.DARKRED);
                glutAddMenuEntry ("Dark green", EColorBack.DARKGREEN);
                glutAddMenuEntry ("Dark blue", EColorBack.DARKBLUE);

                menuDraw = glutCreateMenu (on_glutCreateMenu_EColorDraw);
                glutAddMenuEntry ("White", EColorDraw.WHITE);
                glutAddMenuEntry ("Light red", EColorDraw.LIGHTRED);
                glutAddMenuEntry ("Light green", EColorDraw.LIGHTGREEN);
                glutAddMenuEntry ("Light blue", EColorDraw.LIGHTBLUE);

                menuSolid = glutCreateMenu (on_glutCreateMenu_ESolid);
                glutAddMenuEntry ("Wire", ESolid.WIRE);
                glutAddMenuEntry ("Solid", ESolid.SOLID);

                menuModel = glutCreateMenu (on_glutCreateMenu_EModel);
                glutAddMenuEntry ("Teapot", EModel.TEAPOT);
                glutAddMenuEntry ("Cube", EModel.CUBE);
                glutAddMenuEntry ("Sphere", EModel.SPHERE);
                glutAddMenuEntry ("Cone", EModel.CONE);
                glutAddMenuEntry ("Torus", EModel.TORUS);
                glutAddMenuEntry ("Dodecahedron", EModel.DODECAHEDRON);
                glutAddMenuEntry ("Octahedron", EModel.OCTAHEDRON);
                glutAddMenuEntry ("Tetrahedron", EModel.TETRAHEDRON);
                glutAddMenuEntry ("Icosahedron", EModel.ICOSAHEDRON);

                menuAxes = glutCreateMenu (on_glutCreateMenu_EAxes);
                glutAddMenuEntry ("No axes", EAxes.AXESNO);
                glutAddMenuEntry ("Simple axes", EAxes.AXESSIMPLE);

                menuAnimation = glutCreateMenu (on_glutCreateMenu_Animation);
                glutAddMenuEntry ("Disable", 0);
                glutAddMenuEntry ("Enable", 1);

                menuMain = glutCreateMenu(on_glutCreateMenu);
                glutAddSubMenu ("Background color", menuBack);
                glutAddSubMenu ("Color drawing", menuDraw);
                glutAddSubMenu ("Type of representation", menuSolid);
                glutAddSubMenu ("Model", menuModel);
                glutAddSubMenu ("Axes", menuAxes);
                glutAddSubMenu ("Animation", menuAnimation);

                glutAttachMenu ((int)GLUT_RIGHT_BUTTON);
        }

        protected static void Init_Options () {
                glPolygonMode (GL_FRONT, GL_FILL);
                glFrontFace   (GL_CCW);
                glCullFace    (GL_BACK);
                glEnable      (GL_CULL_FACE);
//              glShadeModel  (GL_FLAT);
                glShadeModel  (GL_SMOOTH);
                glDepthFunc   (GL_LEQUAL);
                glEnable      (GL_DEPTH_TEST);
                glEnable      (GL_NORMALIZE);
        }

        protected static void Init_Lighting () {
                GLfloat[] position = {0.0f, 1.0f, 1.0f, 1.0f};
                GLfloat[] diffuse  = {0.7f, 0.7f, 0.7f, 1.0f};
                GLfloat[] specular = {0.2f, 0.2f, 0.2f, 1.0f};
                GLfloat[] ambient  = {0.2f, 0.2f, 0.2f, 1.0f};

                glLightModelfv (GL_LIGHT_MODEL_AMBIENT, ambient);
                glLightfv (GL_LIGHT0, GL_POSITION, position);
                glLightfv (GL_LIGHT0, GL_DIFFUSE,  diffuse);
                glLightfv (GL_LIGHT0, GL_SPECULAR, specular);

                glEnable (GL_LIGHTING);
                glEnable (GL_LIGHT0);
        }

        protected static void Init_Material () {
                GLfloat[] colorAmbientDiffuse = {0.1f, 0.5f, 0.8f, 1.0f};
                GLfloat[] colorSpecular       = {1.0f, 1.0f, 1.0f, 1.0f};
                GLfloat[] shineSpecular       = {10.0f};

                glMaterialfv (GL_FRONT, GL_AMBIENT_AND_DIFFUSE, colorAmbientDiffuse);
                glMaterialfv (GL_FRONT, GL_SPECULAR, colorSpecular);
                glMaterialfv (GL_FRONT, GL_SHININESS, shineSpecular);
        }

        public static void main (string[] args) {
                preferences = SPreferences ();

                Init_Window (args);
                Init_Events ();
                Init_Menu ();
                Init_Options ();
                Init_Lighting ();
                Init_Material ();

                glutMainLoop();
        }
}
