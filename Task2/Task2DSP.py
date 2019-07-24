#Group4 Asmaa Morad - Laila Mohamed - Moaz Khairy
#Program run as main window contains getting signal and it's plot and buttons for opening subwindows
#Filtration SubWindow for applying digital filter on the obtained signal
#Sampling SubWindow for sampling nature signals
#SoundGeneration Subwindow for generating sound from sinusoids

import matplotlib
import matplotlib.pyplot as plt
matplotlib.use('TkAgg')
import numpy as np
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
from matplotlib.figure import Figure
from tkinter import *
from tkinter.filedialog import askopenfilename
import csv
from csv import reader
import sounddevice as sd
import time

class MClass:

    def __init__(self,  window):
        self.window = window
        window.geometry('700x700+200+0')
        window.title('DSP Task2')
        label1 = Label(text="Browse CSV Signal: ", fg='black', bg='yellow').place(x =0,y=0)

        self.OpenBut = Button(window, text='File Open', command= self.CallBack).place(x=0,y=30)
        self.PlotBut = Button(window, text = 'Plot' , command = self.PlotSignal).place(x = 70, y=30)

        self.FiltrationBut = Button(window, text='Filtration', command= self.Filtration).place(x=150,y=30)
        self.SamplingBut = Button(window, text='Sampling Nature Signals', command= self.Sampling).place(x=240,y=30)
        self.SoundGenerationBut = Button(window, text='Sound Generation', command= self.SoundGeneration).place(x=400,y=30)

    #Open Sound Generation Window
    def SoundGeneration(self):
        WindowSound = Tk()
        WindowSound.title('Audio Generation from Sinusoids and Exponentials')

        self.RandomMix1 = Button(WindowSound, text='First Random Mix', command=self.RandomM1).pack()
        self.RandomMix2 = Button(WindowSound, text='Second Random Mix', command=self.RandomM2).pack()
        self.RandomMix3 = Button(WindowSound, text='Third Random Mix', command=self.RandomM3).pack()
        self.RandomMix4 = Button(WindowSound, text='Fourth Random Mix', command=self.RandomM4).pack()
        self.RandomMix5 = Button(WindowSound, text='Fifth Random Mix', command=self.RandomM5).pack()
        self.RandomMix6 = Button(WindowSound, text='Sixth Random Mix', command=self.RandomM6).pack()
        mainloop()
    #Generating Random Sound Signals
    def RandomM1(self):
        Fs = 44100
        f = 100
        x = np.arange(Fs)
        y1 = np.sin(2 * np.pi * f * x / Fs)
        y2 = np.sin(2 * np.pi * 2 * f * x / Fs)
        y = y1 + y2
        sd.play(y, Fs)
        time.sleep(15)

    def RandomM2(self):
        Fs = 44100
        f = 1000
        x = np.arange(Fs)
        y1 = np.cos(2 * np.pi * f * x / Fs)
        y2 = np.sin(2 * np.pi * 2 * f * x / Fs)
        y = y1 + y2
        sd.play(y, Fs)
        time.sleep(15)

    def RandomM3(self):
        Fs = 44100
        f = 500
        x = np.arange(Fs)
        y1 = np.cos(2 * np.pi * f * x / Fs)
        y2 = np.sin(2 * np.pi * 2 * f * x / Fs)
        y = y1 + y2
        sd.play(y, Fs)
        time.sleep(15)

    def RandomM4(self):
        Fs = 44100
        f = 500
        x = np.arange(Fs)
        y1 = np.cos(2 * np.pi * f * x / Fs)
        y2 = np.exp(-2 * np.pi * 2 * f * x / Fs)
        y = y1 + y2
        sd.play(y, Fs)
        time.sleep(15)

    def RandomM5(self):
        Fs = 44100
        f = 500
        x = np.arange(Fs)
        y1 = np.cos(2 * np.pi * f * x / Fs)
        y2 = np.exp(-2 * np.pi * 2 * f * x / Fs)
        y = y1 * y2
        sd.play(y, Fs)
        time.sleep(15)

    def RandomM6(self):
        Fs = 44100
        f = 500
        x = np.arange(Fs)
        y1 = np.cos(2 * np.pi * f * x / Fs)
        y2 = np.sin(2 * np.pi * 2 * f * x / Fs)
        y = y1 -y2
        sd.play(y, Fs)
        time.sleep(15)

    #Open Sampling Window
    def Sampling(self):
        SamplingW = Tk()
        SamplingW.title('Sampling')

        self.ButExp = Button(SamplingW,text='Sample Exponential wave', command=self.callback1, fg="black", bg="green").pack(fill = X)
        self.ButSin = Button(SamplingW, text='Sample Sin wave', command=self.callback2, fg="black", bg="green").pack(fill = X)
        mainloop()

    def callback1(self): #sampling decaying exponential of Capacitor
        A = 2
        f = 50.0
        T = 1 / f

        fs = 50.0 * f
        Ts = 1 / fs

        cycles = 2
        t = np.arange(0, cycles * T, Ts)
        x =  np.exp( - 2 * np.pi*f* t)

        plt.title("Sampled Decay exponential Capacitor ")
        plt.stem(x)
        plt.show()

    #Sampling Harmonic
    def callback2(self):
        A = 2
        f = 50.0
        T = 1 / f

        fs = 50.0 * f
        Ts = 1 / fs

        cycles = 2
        t = np.arange(0, cycles * T, Ts)
        x = A * np.sin(2 * np.pi * f * t)
        plt.title("Harmonic motion ")
        plt.stem(x)
        plt.show()

    #Creating digital filter for signal from 3 values
    #Plotting Signal before filtration in blue and after filtration in red
    def Filtration(self):
        global WindowFiltration
        WindowFiltration = Tk()
        WindowFiltration.geometry('700x700+200+0')
        WindowFiltration.title('DSP Task2')

        def click():
            Factors = []
            F1g = F1.get()
            Factors.append(F1g)
            F2g = F2.get()
            Factors.append(F2g)
            F3g = F3.get()
            Factors.append(F3g)
            y = Signal
            #to guarantee input is float and list to convolve function
            Factors = np.array(Factors, dtype=float)
            Factors = list(Factors)
            y = np.array(y, dtype=float)
            y = list(y)
            G = np.convolve(Factors,y)

            print(G)
            fig = Figure(figsize=(6, 6))
            a = fig.add_subplot(111)
            a.plot(y, color='blue')
            a.plot(G, color='red')
            canvas = FigureCanvasTkAgg(fig, WindowFiltration)
            canvas.get_tk_widget().grid()
            canvas.draw()

        F1 = Entry(WindowFiltration)
        F1.grid()
        F2 = Entry(WindowFiltration)
        F2.grid()
        F3 = Entry(WindowFiltration)
        F3.grid()
        self.PlotFBut = Button(WindowFiltration, text='Plot', command=click).grid()

        mainloop()

    #read signal from browsing files in operating PC
    def CallBack(self):
        name = askopenfilename(filetypes=[("CSV", ".csv")])
        with open(name, 'r') as f:
            data = list(reader(f))
            global Signal
            Signal_1 = np.asarray(data)
            print(len(Signal_1))
            Signal = Signal_1[:,0]

    #plotting signal
    def PlotSignal(self):
        plt.plot(Signal)
        plt.show()
       # fig = Figure(figsize=(6, 6))
       # a = fig.add_subplot(111)
       # a.plot(Signal, color='blue')
       # canvas = FigureCanvasTkAgg(fig, master=self.window)
       # canvas.get_tk_widget().place(x = 10 , y =60)
       # canvas.draw()





Window = Tk()
m1 = MClass(Window)
mainloop()