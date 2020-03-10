/*
Copyright (c) 2020 thorn ale <thornale1@gmail.com>, elyhaka

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

module basic_shape(r1, r2, h, scale_array, orig=0, nb_faces=360){
  nb = (nb_faces == 360 ? 360 : nb_faces*2);
  difference(){
        scale(scale_array)
          cylinder(r1=r1, r2=r2, h=h, $fn=nb);
    
        translate([orig, -r1*scale_array[1], 0])
          cube([r1*scale_array[0], r1*scale_array[1]*2, h]);
      }
}

module mounting_hole(position, direction, d, h){
  translate(position) 
    rotate(direction)
      cylinder(d=d, h=h, $fn=360);
}

module applique(opening, base, height, bottom_hole, thickness, scale_array, nb_faces){
    difference(){
      difference(){
        basic_shape(opening, base, height, scale_array, nb_faces=nb_faces);
        basic_shape(opening - thickness/2, base - thickness/2, height - thickness/2, scale_array, orig=-thickness, nb_faces=nb_faces);
      }
      translate([0, 0, height-thickness])
        cylinder(d=bottom_hole, h=thickness, $fn=360);
     rail_mount(base, scale_array[1], thickness, just_volume=true);
  }
  
}

module rail_mount(base, scale_y, thickness, just_volume=false){
  mount_width = base*scale_y;
  mount_height = 2*height/3;
  mount_thickness = 3*thickness;
  difference(){
    translate([-2/3*mount_thickness,-mount_width/2,height/3-thickness])
      cube(size=[mount_thickness,mount_width,mount_height]);
    translate([-2/3*mount_thickness+thickness,-mount_width/2,height/3-thickness])
      cube(size=[thickness,thickness,mount_height]);
    translate([-2/3*mount_thickness+thickness,mount_width/2-thickness,height/3-thickness])
      cube(size=[thickness,thickness,mount_height]);
    translate([-1/3*mount_thickness,-mount_width/2,height/3-thickness])
      cube(size=[thickness,mount_width,thickness]);
    if(!just_volume) {
      mounting_hole(
        [-2*mount_thickness/3, mount_width/4, 2*mount_height/3 + height/3-thickness],
        [0,90,0],
        d=diam_screw,
        h=mount_thickness);
      
      mounting_hole(
        [-2*mount_thickness/3, -mount_width/4, 2*mount_height/3 + height/3-thickness],
        [0,90,0],
        d=diam_screw,
        h=mount_thickness);
      
       mounting_hole([-2*mount_thickness/3, mount_width/4, mount_height/3 + height/3-thickness],
        [0,90,0],
        d=diam_screw,
        h=mount_thickness);
        
      mounting_hole(
        [-2*mount_thickness/3, -mount_width/4, mount_height/3 + height/3-thickness],
        [0,90,0],
        d=diam_screw,
        h=mount_thickness);
    }
  }

}

opening = 50;
base = 15;
height = 150;
thickness = 2.4;

nb_faces = 7;

bottom_hole = 26;
diam_screw = 3;

scale_x = 1.5;
scale_y = 1.5;
scale_z = 1;

scale_array = [scale_x, scale_y, scale_z]; 
if(step == "applique") applique(opening, base, height, bottom_hole, thickness, scale_array, nb_faces);
if(step == "rail") rotate([90,90,0]) rail_mount(base, scale_y, thickness);

