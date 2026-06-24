if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="OrtikEx_Materi-1";
if(settings.render < 0) settings.render=4;
settings.outformat="";
settings.inlineimage=true;
settings.embed=true;
settings.toolbar=false;
viewportmargin=(2,2);

defaultpen(fontsize(10pt));
size(8cm); // set a reasonable default
usepackage("amsmath");
usepackage("amssymb");
settings.tex="pdflatex";
settings.outformat="pdf";
// Replacement for olympiad+cse5 which is not standard
import geometry;
// recalibrate fill and filldraw for conics
void filldraw(picture pic = currentpicture, conic g, pen fillpen=defaultpen, pen drawpen=defaultpen)
{ filldraw(pic, (path) g, fillpen, drawpen); }
void fill(picture pic = currentpicture, conic g, pen p=defaultpen)
{ filldraw(pic, (path) g, p); }
// some geometry
pair foot(pair P, pair A, pair B) { return foot(triangle(A,B,P).VC); }
pair orthocenter(pair A, pair B, pair C) { return orthocentercenter(A,B,C); }
pair centroid(pair A, pair B, pair C) { return (A+B+C)/3; }
// cse5 abbrevations
path CP(pair P, pair A) { return circle(P, abs(A-P)); }
path CR(pair P, real r) { return circle(P, r); }
pair IP(path p, path q) { return intersectionpoints(p,q)[0]; }
pair OP(path p, path q) { return intersectionpoints(p,q)[1]; }
path Line(pair A, pair B, real a=0.6, real b=a) { return (a*(A-B)+A)--(b*(B-A)+B); }
// cse5 more useful functions
picture CC() {
picture p=rotate(0)*currentpicture;
currentpicture.erase();
return p;
}
pair MP(Label s, pair A, pair B = plain.S, pen p = defaultpen) {
Label L = s;
L.s = "$"+s.s+"$";
label(L, A, B, p);
return A;
}
pair Drawing(Label s = "", pair A, pair B = plain.S, pen p = defaultpen) {
dot(MP(s, A, B, p), p);
return A;
}
path Drawing(path g, pen p = defaultpen, arrowbar ar = None) {
draw(g, p, ar);
return g;
}

size(10cm);
pair A = dir(110);
pair B = dir(210);
pair C = dir(330);
pair M = midpoint(B--C);
pair H = orthocenter(A, B, C);
pair G = foot(A, M, H);
pair Q = foot(H, A, M);
pair D = foot(A, B, C);
pair E = foot(B, C, A);
pair F = foot(C, A, B);

filldraw(A--B--C--cycle, opacity(0.1)+lightred, red);
filldraw(unitcircle, opacity(0.1)+yellow, red);
draw(A--D, red);
draw(B--E, red);
draw(C--F, red);

pair T = extension(E, F, B, C);
draw(A--M, red);
draw(A--T--Q, orange+dashed);
draw(E--T--B, red);
draw(G--M, orange+dashed);

filldraw(circumcircle(A, E, F), opacity(0.1)+lightblue, blue);
filldraw(circumcircle(D, E, C), opacity(0)+lightblue, blue+dashed);
filldraw(circumcircle(D, F, B), opacity(0)+lightblue, blue+dashed);
filldraw(circumcircle(B, E, C), opacity(0.1)+lightgreen, green);
filldraw(circumcircle(D, A, C), opacity(0)+lightblue, green+dashed);
filldraw(circumcircle(D, E, A), opacity(0)+lightblue, green+dashed);

filldraw(circumcircle(E, D, F), opacity(0)+lightred, black);
dot("$A$", A, dir(A));
dot("$B$", B, dir(B));
dot("$C$", C, dir(C));
dot("$M$", M, dir(M));
dot("$H$", H, dir(H));
dot("$Q$", Q, dir(335));
dot("$D$", D, dir(D));
dot("$E$", E, dir(20));
dot("$F$", F, dir(F));
// dot("$T$", T, dir(T));
dot(T);
dot("$G$", G, dir(G));
