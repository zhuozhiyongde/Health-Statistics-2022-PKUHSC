# -*- encoding: utf-8 -*-
#@Author  :   Arthals
#@File    :   Homework7.py
#@Time    :   2022/11/14 16:29:24
#@Contact :   zhuozhiyongde@126.com
#@Software:   Visual Studio Code


def Part1():
    before = [6000, 22000, 5900, 4400, 6000, 6500, 26000, 5800]
    after = [660, 5600, 3700, 5000, 6300, 1200, 1800, 2200]
    diff = [after[i] - before[i] for i in range(len(before))]
    diff_index = [(index + 1, diff_value)
                  for index, diff_value in enumerate(diff)]
    diff_index = sorted(diff_index, key=lambda x: abs(x[1]))
    diff_index = [(index, diff_value) for index, diff_value in diff_index
                  if diff_value != 0]
    print(diff_index)

    # 给出秩和
    rank_dic = {}
    for index, diff_value in diff_index:
        if abs(diff_value) in rank_dic.keys():
            rank_dic[abs(diff_value)].append(diff_value / abs(diff_value))
        else:
            rank_dic[abs(diff_value)] = [diff_value / abs(diff_value)]

    rank_pos = 0
    rank_neg = 0
    temp_rank = 1
    for rank in rank_dic.keys():
        # print(f"{rank}:{temp_rank}~{temp_rank + len(rank_dic[rank]) - 1}")
        total_rank = sum(range(temp_rank, temp_rank + len(rank_dic[rank])))
        rank_pos += len([
            pos_num for pos_num in rank_dic[rank] if pos_num == 1
        ]) / len(rank_dic[rank]) * total_rank
        # print(f"正秩和:{rank_pos}")

        rank_neg += len([
            pos_num for pos_num in rank_dic[rank] if pos_num == -1
        ]) / len(rank_dic[rank]) * total_rank
        # print(f"负秩和:{rank_neg}")

        temp_rank += len(rank_dic[rank])
    print(f"rank_pos:{rank_pos}")
    print(f"rank_neg:{rank_neg}")


def Part2():
    new_drug = [34.5, 33.0, 32.5, 30.5, 29.5, 25.5, 25.0, 24.4, 23.6, 21.4]
    regular_drug = [30.0, 28.5, 28.0, 26.0, 25.0, 21.0, 20.5, 19.9, 19.0, 17.1]
    drug_total = []
    drug_total.extend([(1, new_drug_value) for new_drug_value in new_drug])
    drug_total.extend([(2, regular_drug_value)
                       for regular_drug_value in regular_drug])

    drug_total = sorted(drug_total, key=lambda x: x[1])
    print(drug_total)
    print(len(drug_total))
    rank_total = []
    pass_num = 0
    for index, (group, value) in enumerate(drug_total):
        if (pass_num):
            pass_num -= 1
            continue
        # print(f"start:{index}")
        rank = index + 1
        same = 0
        for i in range(index, len(drug_total)):
            if drug_total[i][1] == value:
                same += 1
            else:
                break
        # print(f"{value}:{rank}~{rank + same - 1},same:{same}")
        for i in range(index, index + same):
            rank_total.append(
                (drug_total[i][0],
                 sum([j for j in range(rank, rank + same)]) / same))
        pass_num = same - 1
    print(rank_total)

    # 计算秩和
    rank_group = [
        sum([rank for group, rank in rank_total if group == i])
        for i in range(1, 3)
    ]
    print(len(new_drug), len(regular_drug))
    print(rank_group)


def Part3():
    g_a = [
        45, 56, 57, 57, 60.3, 63, 64, 64, 64, 66, 66, 66, 66, 67, 70, 70, 70,
        71, 74, 74, 76, 73, 93, 95
    ]
    g_b = [
        51, 51, 54, 54, 59, 61, 61, 61, 62, 68, 68, 70, 70, 71, 70, 87, 89, 91,
        93
    ]
    g_c = [46, 31, 56, 48, 43, 24, 18, 36, 44, 36, 36, 24, 18, 36, 44, 36]
    g_total = []
    g_total.extend([(1, g_a_value) for g_a_value in g_a])
    g_total.extend([(2, g_b_value) for g_b_value in g_b])
    g_total.extend([(3, g_c_value) for g_c_value in g_c])
    g_total = sorted(g_total, key=lambda x: x[1])
    print(g_total)
    print(len(g_total))
    rank_total = []
    pass_num = 0
    for index, (group, value) in enumerate(g_total):
        if (pass_num):
            pass_num -= 1
            continue
        # print(f"start:{index}")
        rank = index + 1
        same = 0
        for i in range(index, len(g_total)):
            if g_total[i][1] == value:
                same += 1
            else:
                break
        # print(f"{value}:{rank}~{rank + same - 1},same:{same}")
        for i in range(index, index + same):
            rank_total.append(
                (g_total[i][0],
                 sum([j for j in range(rank, rank + same)]) / same))
        pass_num = same - 1
        # print(f"change_index:{index}")
    # print(rank_total)

    # for index in range(len(g_total)):
    #     print(f"{g_total[index][1]}:{rank_total[index][1]}")
    g_rank = []
    for i in range(1, 4):
        g_rank.append(sum([rank for group, rank in rank_total if group == i]))
    print(f"group_rank:{g_rank}")
    h_statistic = 12 / (len(g_total) * (len(g_total) + 1)) * sum([
        g_rank[i]**2 / len([j for j in g_total if j[0] == i + 1])
        for i in range(3)
    ]) - 3 * (len(g_total) + 1)
    print("group_rank:",
          [(g_rank[i], len([j for j in g_total if j[0] == i + 1]))
           for i in range(3)])
    print(f"h_statistic:{h_statistic}")


def Part4():
    import numpy as np
    data = np.array([[630, 487, 720, 619], [621, 387, 601, 567],
                     [546, 316, 539, 531], [498, 257, 264, 367],
                     [523, 286, 310, 432], [531, 367, 431, 422],
                     [520, 345, 492, 489], [532, 324, 335, 316],
                     [623, 321, 620, 611], [664, 432, 656, 597]])
    group, solution = data.shape
    for g in range(group):
        if len(set(data[g])) != len(data[g]):
            print(f"第{g+1}组数据有重复")

    # 校验没有重复后直接按大小编秩
    data_change = []
    for g in range(group):
        inside = [(index, value) for index, value in enumerate(data[g])]
        print(f"第{g+1}组数据:{inside}")
        inside = sorted(inside, key=lambda x: x[1])
        inside = [(index, rank + 1)
                  for rank, (index, value) in enumerate(inside)]
        print(f"第{g+1}组数据:{inside}")
        data_change.append(inside)

    print(data)
    # 计算秩和
    g_rank = []
    for s in range(solution):
        s_rank = 0
        for g in range(group):
            s_rank += sum([
                data_change[g][i][1] for i in range(solution)
                if data_change[g][i][0] == s
            ])
        g_rank.append(s_rank)

        print(f"Rank{s+1}: {s_rank}")
    m_stastic = sum([(g_rank[i] - sum(g_rank) / solution)**2
                     for i in range(solution)])
    print(f"m_stastic:{m_stastic}")


if __name__ == '__main__':
    Part1()