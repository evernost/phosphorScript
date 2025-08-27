# -*- coding: utf-8 -*-
# =============================================================================
# Project       : phosphorScript
# Module name   : capture
# File name     : capture.py
# File type     : Python script (Python 3)
# Purpose       : shape capture app
# Author        : QuBi (nitrogenium@outlook.fr)
# Creation date : Tuesday, 26 April 2025
# -----------------------------------------------------------------------------
# Best viewed with space indentation (2 spaces)
# =============================================================================

# =============================================================================
# EXTERNALS
# =============================================================================
# Project specific constants
# None.

# Standard libs
import tkinter as tk
from tkinter import filedialog
from PIL import Image, ImageTk



# =============================================================================
# CLASS DEFINITION
# =============================================================================
class shapeCapture :
  
  """
  SHAPECAPTURE object definition

  Description is TODO.
  """

  def __init__(self, root, image_path) :
    self.root = root
    self.root.title("shapeCapture app")

    # Load image
    self.image = Image.open(image_path)
    self.tk_image = ImageTk.PhotoImage(self.image)

    # Canvas for drawing
    self.canvas = tk.Canvas(root, width=self.image.width, height=self.image.height)
    self.canvas.pack()
    self.canvas.create_image(0, 0, anchor=tk.NW, image=self.tk_image)

    # State
    self.points = []
    self.lines = []

    # Bind events
    self.canvas.bind("<Button-1>", self.addPoint)
    self.root.bind("<s>", self.exportShape)
    self.root.bind("<c>", self.clearPoints)


  # ---------------------------------------------------------------------------
  # METHOD shapeCapture.addPoint()
  # ---------------------------------------------------------------------------
  def addPoint(self, event) :
    x, y = event.x, event.y
    self.points.append((x, y))

    # Draw dot
    r = 3
    self.canvas.create_oval(x-r, y-r, x+r, y+r, fill = "red", outline = "red")

    # Draw line from last point to current
    if len(self.points) > 1:
      x0, y0 = self.points[-2]
      line = self.canvas.create_line(x0, y0, x, y, fill="blue", width=2)
      self.lines.append(line)

    print(f"x = {x}, y = {y}")



  # ---------------------------------------------------------------------------
  # METHOD shapeCapture.exportShape()
  # ---------------------------------------------------------------------------
  def exportShape(self, event = None):
    if not self.points:
      print("No points to save.")
      return

    filename = filedialog.asksaveasfilename(defaultextension=".txt", filetypes=[("Text Files", "*.txt")])
    if filename:
      with open(filename, "w") as f :
        for (x, y) in self.points :
          f.write(f"{x}, {y}\n")
      print(f"Saved {len(self.points)} points to {filename}")



  # ---------------------------------------------------------------------------
  # METHOD shapeCapture.clearPoints()
  # ---------------------------------------------------------------------------
  def clearPoints(self, event = None) :
    for line in self.lines:
      self.canvas.delete(line)
    self.lines.clear()

    self.canvas.delete("all")
    self.canvas.create_image(0, 0, anchor=tk.NW, image=self.tk_image)
    self.points.clear()
    print("Cleared all points.")



# =============================================================================
# UNIT TESTS
# =============================================================================
if (__name__ == "__main__") :
  
  root = tk.Tk()
  
  file_path = filedialog.askopenfilename(filetypes = [("Image Files", "*.png;*.jpg;*.jpeg;*.bmp")])
  
  if file_path :
    app = shapeCapture(root, file_path)
    root.mainloop()
