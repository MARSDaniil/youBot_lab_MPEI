// Control_of_robots_lab1.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <algorithm>
#include <fstream>

using namespace std;

unsigned int lenght_of_vector(); //узнаем количество строк в входном файле
void open_file(vector<int>& Vx, vector<int>& Vy, vector<int>& OM); // открываем файлами для сепарации данных
void correct_file(const ifstream& file); // проверяем наличие входного файла
void push_data_to_output(); // помещение данных в выходной файл
void digit_separator(string str, vector<int>& Vx, vector<int>& Vy, vector<int>& OM, unsigned int counter); // разделение входных данных на три и запись их в соответствующие векторы
void vector_output(vector<int>& Vx, string name_of_vector); // вывод векторов на консоль
//void push_data_to_youBot(vector<int>& Vx, vector<int>& Vy, vector<int>& OM); // помещение данных из векторов в youBot
//void get_data_by_youBot(); // снятие данных с робота

int main()
{
    const unsigned int lenght = lenght_of_vector(); //находим длины для векторов
    vector<int> Vx(lenght); // создаем соответствующие векторы нужной длины
    vector<int> Vy(lenght);
    vector<int> OM(lenght);
    open_file(Vx,Vy,OM); // открываем файл
    string output = "output.txt";
    ofstream output_status_data;
    output_status_data.open(output, fstream::out);
   // push_data_to_youBot(Vx,Vy,OM);
    
    //vector_output(Vx, "Vx");
    //vector_output(Vy, "Vy");
    //vector_output(OM, "OM");
}
unsigned int lenght_of_vector()
{
    string input = "input.txt";
    ifstream input_data_of_velosity;
    input_data_of_velosity.open(input, fstream::in);
    correct_file(input_data_of_velosity);
    unsigned int lenght_of_vector = 0;
    while (getline(input_data_of_velosity, input))
    {
        lenght_of_vector++;
    }
    input_data_of_velosity.seekg(0);
    //cout << "lenght_of_vector = " << lenght_of_vector << endl;
    input_data_of_velosity.clear();
    input_data_of_velosity.seekg(0L, std::ios_base::beg); // после чтения файла возвращаемся к первой строке, когда писал все в open_file - было необходимо, возможно в функции не требуется, но проверять лень 
    return(lenght_of_vector);
}
void vector_output(vector<int>& Vx, string name_of_vector)
{
    int i = 0;
    cout << "Vector: "<< name_of_vector << endl;
    while (i < Vx.size())
    {
        cout << Vx[i] << endl;
        i++;
    }
}
void open_file(vector<int>& Vx, vector<int>& Vy, vector<int>& OM)
{
    
    string input = "input.txt";
    ifstream input_data_of_velosity;
    input_data_of_velosity.open(input, fstream::in);
    //correct_file(input_data_of_velosity);
    unsigned int i = 0;
    while (getline(input_data_of_velosity, input)) //проход по файлу построчно
    {
        string str = input;

        digit_separator(str, Vx, Vy, OM, i);
        i++;
    }
    //cout << i << endl;
    
}

void digit_separator(string str, vector<int>& Vx, vector<int>& Vy, vector<int>& OM, unsigned int counter)
{
    int number_determinant = 0; //счетчик для записи в Vx,Vy,Om; j == 0 - Vx, j == 1 - Vy, j == 2 - Om
    unsigned int number = 0;
    for (int i = 0; i < str.size(); i++)
    {   
        
        if (str[i] >= '0' && str[i] <= '9')
        {   
            number = number * 10;
            number = number + str[i] - '0';
        }
        if (str[i + 1] == ' ' || str[i + 1] == '\0')
        {
            switch (number_determinant)
            {
            case 0:
            {
                Vx[counter] = number;
            }
            case 1:
            {
                Vy[counter] = number;
            }
            case 2:
            {
                OM[counter] = number;
            }
            default:
                break;
            }
            number = 0;
            number_determinant++;
        }

    }
  //  cout << "number_determinant = " << number_determinant << endl;
    //cout << endl;
}

void correct_file(const ifstream& file)
{
    if (!file)
    {
        //cout << "no input file" << endl;
        exit(-1);
    }
    else
    {
        //cout << "file is open" << endl;
    }
}
/*
void push_data_to_youBot(vector<int>& Vx, vector<int>& Vy, vector<int>& OM)
{
    unsigned int i = 0;
    while (i < Vx.size())
    {
        longitudinalVelocity = Vx[i] * meter_per_second;
        transversalVelocity = Vy[i] * meter_per_second;
        angularVelocity = OM[i] * radian_per_second;
        myYouBotBase->setBaseVelocity(longitudinalVelocity, transversalVelocity, angularVelocity);
        SLEEP_MILLISEC(100);
        i++;
    }
}
*/
/*
void get_data_by_youBot()
{
    float trq1;
    float trq2;
    float trq3;
    float trq4;
    float omega_1;
    float omega_2;
    float omega_3;
    float omega_4;

    myYouBotBase->getBaseJoint(1).getData(sensedTorque); //снятие данных с датчиков колс
    trq1 = -(sensedTorque.torque) / newton_meter;
    myYouBotBase->getBaseJoint(2).getData(sensedTorque);
    trq2 = (sensedTorque.torque) / newton_meter;
    myYouBotBase->getBaseJoint(3).getData(sensedTorque);
    trq3 = -(sensedTorque.torque) / newton_meter;
    myYouBotBase->getBaseJoint(4).getData(sensedTorque);
    trq4 = (sensedTorque.torque) / newton_meter;
    
    myYouBotBase->getBaseJoint(1).getData(sensedVelo);//Снятие угловых скоростей с датчиков колес
    omega_1 = -sensedVelo.angularVelocity / radian_per_second;
    myYouBotBase->getBaseJoint(2).getData(sensedVelo);
    omega_2 = sensedVelo.angularVelocity / radian_per_second;
    myYouBotBase->getBaseJoint(3).getData(sensedVelo);
    omega_3 = -sensedVelo.angularVelocity / radian_per_second;
    myYouBotBase->getBaseJoint(4).getData(sensedVelo);
    omega_4 = sensedVelo.angularVelocity / radian_per_second;

}
*/
void push_data_to_output(vector<int>& Vx, vector<int>& Vy, vector<int>& OM)
{
    string output = ("output.txt",std::ios::app);
    ofstream output_status_data;
    output_status_data.open(output, fstream::out);
    int i = 0;
    while (i< Vx.size())
    {
        
    }
}

