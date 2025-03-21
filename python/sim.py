import pandas as pd
import matplotlib.pyplot as plt
from scipy import signal
import numpy as np



def lowpass(x, samplerate):
    fp = 1                         # 通過域端周波数[Hz]
    fs = 40                         # 阻止域端周波数[Hz]
    gpass = 1                       # 通過域最大損失量[dB]
    gstop = 40                      # 阻止域最小減衰量[dB]

    # # dfをarrayに
    # x_array = x.values

    # 時系列のサンプルデータ作成

    n = len(x)                         # データ数
    dt = 1/samplerate                       # サンプリング間隔
    fn = 1/(2*dt)                   # ナイキスト周波数

    # column_num = len(x_array[0, :])

    #print('t=',t)
    # data_lp = np.array([[0]*column_num for i in range(n)], dtype='float32')

    # 正規化
    Wp = fp/fn
    Ws = fs/fn

    # ローパスフィルタで波形整形
    # バターワースフィルタ
    N, Wn = signal.buttord(Wp, Ws, gpass, gstop)
    b1, a1 = signal.butter(N, Wn, "low")

    # for i in range(column_num):
    x = signal.filtfilt(b1, a1, x[:, 0])

    return pd.DataFrame(data=x, columns=x.columns)

# binarization_data = pd.read_csv("simulation/2024_1209/1/binarization_out1.csv",names = ['Time (ms)'])
dff_data = pd.read_csv("simulation/2024_1209/1/dff_out1.csv",names = ['Time (ms)'])
# xor_data = pd.read_csv("simulation/2024_1209/1/mixer_out1.csv",names = ['Time (ms)'])
# c1_data =  pd.read_csv("simulation/2024_1209/1/c1.csv",names = ['Time (ms)'])

binarization_data = pd.read_csv("simulation/2025_0312/12/dfil_new_out1.csv",names = ['Time (ms)'])
xor_data = pd.read_csv("simulation/2025_0312/12/mixer_out1.csv",names = ['Time (ms)'])
c1_data =  pd.read_csv("simulation/2025_0312/12/c1.csv",names = ['Time (ms)'])

print(binarization_data)
print(xor_data)

dff_data = dff_data * 0.0000001
print(dff_data)

binarization_data = binarization_data * 0.0000001
print(binarization_data)

xor_data = xor_data *0.0000001
print(xor_data)


c1_data = c1_data * 0.0000001
print(c1_data)
# 時間軸を生成する（例: 0～2秒を1 ms刻みでサンプリング）
time_resolution = 0.0001  # 1 ms
time = np.arange(0, 1000, time_resolution)

# 波形を生成する
waveform1 = np.zeros_like(time)
state = 0  # 初期状態（Low）

edge_times = binarization_data['Time (ms)'].values
edge_index = 0

for i, t in enumerate(time):
    # 現在の時間がエッジの時間を超えたら状態を切り替える
    if edge_index < len(edge_times) and t >= edge_times[edge_index]:
        state = 1 - state  # 0 → 1, 1 → 0 の切り替え
        edge_index += 1
    waveform1[i] = state

# 波形をプロットする
plt.figure(figsize=(10, 4))
plt.plot(time, waveform1, drawstyle='steps-pre')
plt.xlabel("Time (ms)")
plt.ylabel("Amplitude")
plt.title("Reconstructed Waveform")
plt.xlim(850,950)
plt.grid(True)
plt.show()

waveform2 = np.zeros_like(time)
state = 0  # 初期状態（Low）

edge_times = xor_data['Time (ms)'].values
edge_index = 0

for i, t in enumerate(time):
    # 現在の時間がエッジの時間を超えたら状態を切り替える
    if edge_index < len(edge_times) and t >= edge_times[edge_index]:
        state = 1 - state  # 0 → 1, 1 → 0 の切り替え
        edge_index += 1
    waveform2[i] = state

# 波形をプロットする
# sensor
plt.figure(figsize=(10, 4))
plt.plot(time, waveform2, drawstyle='steps-pre')
plt.xlabel("Time (ms)")
plt.ylabel("Amplitude")
plt.title("Reconstructed Waveform")
plt.xlim(965,968)
plt.grid(True)
plt.show()

# 波形をプロットする
# xor
plt.figure(figsize=(10, 4))
plt.plot(time, waveform2, drawstyle='steps-pre',alpha = 0.5,color = 'b')
plt.plot(time, waveform1, drawstyle='steps-pre',color = 'r')
plt.xlabel("Time (ms)")
plt.ylabel("Amplitude")
plt.title("Reconstructed Waveform")
plt.xlim(965,968)
plt.grid(True)
plt.show()


# # 波形をプロットする
# plt.figure(figsize=(10, 4))
# plt.plot(time, waveform2, drawstyle='steps-pre')
# plt.xlabel("Time (ms)")
# plt.ylabel("Amplitude")
# plt.title("Reconstructed Waveform")
# plt.xlim(966.3,966.7)
# plt.grid(True)
# plt.show()

# # 波形をプロットする
# plt.figure(figsize=(10, 4))
# plt.plot(time, waveform2, drawstyle='steps-pre',alpha = 0.5,color = 'b')
# plt.plot(time, waveform1, drawstyle='steps-pre',color = 'r')
# plt.xlabel("Time (ms)")
# plt.ylabel("Amplitude")
# plt.title("Reconstructed Waveform")
# plt.xlim(966.3,966.7)
# plt.grid(True)
# plt.show()

# # 波形をプロットする
# plt.figure(figsize=(10, 4))
# plt.plot(time, waveform2, drawstyle='steps-pre')
# plt.xlabel("Time (ms)")
# plt.ylabel("Amplitude")
# plt.title("Reconstructed Waveform")
# plt.xlim(967.4,967.6)s
# plt.grid(True)
# plt.show()

# # 波形をプロットする
# plt.figure(figsize=(10, 4))
# plt.plot(time, waveform2, drawstyle='steps-pre',alpha = 0.5,color = 'b')
# plt.plot(time, waveform1, drawstyle='steps-pre',color = 'r')
# plt.xlabel("Time (ms)")
# plt.ylabel("Amplitude")
# plt.title("Reconstructed Waveform")
# plt.xlim(967.4,967.6)
# plt.grid(True)
# plt.show()

# # 波形をプロットする
# plt.figure(figsize=(10, 4))
# plt.plot(time, waveform2, drawstyle='steps-pre')
# plt.xlabel("Time (ms)")
# plt.ylabel("Amplitude")
# plt.title("Reconstructed Waveform")
# plt.xlim(968.3,968.7)
# plt.grid(True)
# plt.show()

# # 波形をプロットする
# plt.figure(figsize=(10, 4))
# plt.plot(time, waveform2, drawstyle='steps-pre',alpha = 0.5,color = 'b')
# plt.plot(time, waveform1, drawstyle='steps-pre',color = 'r')
# plt.xlabel("Time (ms)")
# plt.ylabel("Amplitude")
# plt.title("Reconstructed Waveform")
# plt.xlim(968.3,968.7)
# plt.grid(True)
# plt.show()

# # 波形をプロットする
# plt.figure(figsize=(10, 4))
# plt.plot(time, waveform2, drawstyle='steps-pre')
# plt.xlabel("Time (ms)")
# plt.ylabel("Amplitude")
# plt.title("Reconstructed Waveform")
# plt.xlim(969.4,969.6)
# plt.grid(True)
# plt.show()

# # 波形をプロットする
# plt.figure(figsize=(10, 4))
# plt.plot(time, waveform2, drawstyle='steps-pre',alpha = 0.5,color = 'b')
# plt.plot(time, waveform1, drawstyle='steps-pre',color = 'r')
# plt.xlabel("Time (ms)")
# plt.ylabel("Amplitude")
# plt.title("Reconstructed Waveform")
# plt.xlim(969.4,969.6)
# plt.grid(True)
# plt.show()




times = c1_data['Time (ms)']  # エッジ時間 (ms単位)

# 周波数計算関数
def calculate_frequency(time_range):
    # 指定範囲内のエッジを抽出
    filtered_times = times[(times >= time_range[0]) & (times <= time_range[1])].values
    
    # 周期を計算 (立ち上がり間隔を基準とする)
    periods = filtered_times[1:] - filtered_times[:-1]  # 隣接エッジ間の時間差
    frequencies = 1 / periods  # 周波数を計算 (Hz)
    
    # 平均周波数 (もし1周期しかない場合、その値がそのまま)
    avg_frequency = frequencies.mean() if len(frequencies) > 0 else None
    return avg_frequency

# 各範囲の周波数を計算
freq_50_100 = calculate_frequency((50, 100))
freq_900_905 = calculate_frequency((900, 905))

# 結果を表示
print(f"50–100msの平均周波数: {freq_50_100} kHz")
print(f"900–950msの平均周波数: {freq_900_905} kHz")


times = c1_data.iloc[:, 0].values

# 周期の計算
periods = times[1:] - times[:-1]  # 隣接するエッジ間の差
periods = 1/periods


# 横軸用の中間時間を計算 (2つのエッジの中央)
mid_times = (times[1:] + times[:-1]) / 2

# グラフをプロット
# sensor 周波数
plt.figure(figsize=(10, 6))
plt.plot(mid_times, periods, color='b',label = 'cantilever1')
plt.xlabel('Time (ms)', fontsize=14)
# plt.xlim(0,2000)
# plt.ylim(40.35,40.6)
plt.ylabel('Frequency (kHz)', fontsize=14)
plt.legend()
plt.grid(True)
plt.show()

# # グラフをプロット
# # sensor　周波数
# plt.figure(figsize=(10, 6))
# plt.plot(mid_times, periods, color='b',label = 'cantilever1')
# plt.xlabel('Time (ms)', fontsize=14)
# plt.xlim(0,2000)
# plt.ylabel('Frequency (kHz)', fontsize=14)
# plt.grid(True)
# plt.show()



times1 = binarization_data.iloc[:, 0].values

# 周期の計算
periods1 = times1[1:] - times1[:-1]  # 隣接するエッジ間の差
periods1 = 1/periods1
periods1_series = pd.Series(periods1)


# 横軸用の中間時間を計算 (2つのエッジの中央)
mid_times1 = (times1[1:] + times1[:-1]) / 2
mid_times1_series = pd.Series(mid_times1)

# プロット
# フィルタ
plt.figure(figsize=(10, 6))
plt.plot(mid_times1, periods1, color='r',label = 'filter output1')
plt.xlabel('Time (ms)', fontsize=14)
# plt.xlim(0,2000)
plt.ylabel('Frequency (kHz)', fontsize=14)
plt.legend()
plt.grid(True)
plt.show()

# グラフをプロット
# フィルタ
plt.figure(figsize=(10, 6))
plt.plot(mid_times1, periods1, color='r',label = 'filter output1')
plt.xlabel('Time (ms)', fontsize=14)
plt.xlim(0,2000)
# plt.ylim(0,1.2)
plt.ylabel('Frequency (kHz)', fontsize=14)
plt.legend()
plt.grid(True)
plt.show()

# グラフをプロット
# フィルタ
plt.figure(figsize=(10, 6))
plt.plot(mid_times1, periods1, color='r',label = 'filter output')
plt.xlabel('Time (ms)', fontsize=14)
plt.ylabel('Frequency (kHz)', fontsize=14)
plt.xlim(700,800)
# plt.ylim(0.6,1.1)
plt.legend()
plt.grid(True)
plt.show()

mid_times1_rolling =mid_times1_series.rolling(window=50,center=True).mean()
periods1_rolling =periods1_series.rolling(window=50,center=True).mean()
# 移動平均
plt.plot(mid_times1_rolling,periods1_rolling,color='g',label = 'filter output1')
plt.xlabel('Time (ms)', fontsize=14)
# plt.xlim(0,2000)
# plt.ylim(0.85,1.05)
plt.ylabel('Frequency (kHz)', fontsize=14)
plt.legend()
plt.grid(True)
plt.show()

# 移動平均
plt.plot(mid_times1_rolling,periods1_rolling,color='g',label = 'filter output1')
plt.xlabel('Time (ms)', fontsize=14)
plt.xlim(500,2000)
# plt.ylim(0.85,1.05)
plt.ylabel('Frequency (kHz)', fontsize=14)
plt.legend()
plt.grid(True)
plt.show()






# times2 = dff_data.iloc[:, 0].values

# # 周期の計算
# periods2 = times2[1:] - times2[:-1]  # 隣接するエッジ間の差
# periods2 = 1/periods2
# periods2_series = pd.Series(periods2)


# # 横軸用の中間時間を計算 (2つのエッジの中央)
# mid_times2 = (times2[1:] + times2[:-1]) / 2
# mid_times2_series = pd.Series(mid_times2)


# # グラフをプロット
# plt.figure(figsize=(10, 6))
# plt.plot(mid_times2, periods2, color='r',label = 'dff output1')
# plt.xlabel('Time (ms)', fontsize=14)
# plt.ylabel('Frequency (kHz)', fontsize=14)
# plt.legend()
# plt.grid(True)
# plt.show()

# # グラフをプロット
# plt.figure(figsize=(10, 6))
# plt.plot(mid_times2, periods2, color='r',label = 'dff output')
# plt.xlabel('Time (ms)', fontsize=14)
# plt.ylabel('Frequency (kHz)', fontsize=14)
# plt.xlim(950,1050)
# plt.ylim(0.6,1.1)
# plt.legend()
# plt.grid(True)
# plt.show()

# mid_times2_rolling =mid_times2_series.rolling(window=50,center=True).mean()
# periods2_rolling =periods2_series.rolling(window=50,center=True).mean()

# plt.plot(mid_times2_rolling,periods2_rolling,color='r',label = 'dff output1')
# plt.xlabel('Time (ms)', fontsize=14)
# plt.ylabel('Frequency (kHz)', fontsize=14)
# plt.legend()
# plt.grid(True)
# plt.show()

# periods1_filter = lowpass(periods1_series, 1000)

# plt.plot(periods1_filter)
# plt.show()