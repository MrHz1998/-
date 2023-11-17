function [PL, PL_succed, PL_succed_car_xuhao_number, PL_succed_car_xuhao_weight, T_car_remain_at_station, PL_succed_Number]=peiliu(C_time_sxoffer,C_come_dir,C_leave_dir,Cdd,Ccf,C_leave_length_min,C_leave_length_max,C_leave_weight_min,C_leave_weight_max,C_weight_direction_of_train)
[Cdd_row,Cdd_column]=size(Cdd);                 %��Cվ�����г���Ϣ����к���
[Ccf_row,Ccf_column]=size(Ccf);                 %��Cվ�����г���Ϣ����к���
C_time_nowoffer=C_time_sxoffer;                 %��վ�����г�ʱ�������������
[C_time_nowoffer_row,C_time_nowoffer_column]=size(C_time_nowoffer);
[C_come_row,C_come_column]=size(C_come_dir);
C_Car_information=C_come_dir;                   %��վ�����г���Ϣ����
PL=[];
PL_number=1;
PL_succed=[];
PL_succed_num=1;
PL_succed_Number=[];
PL_succed_car_xuhao_number=[];                  %���������ɹ�����г���
PL_succed_car_xuhao_weight=[];                  %���������ɹ�����г�����Ӧ������
T_car_remain_at_station=0;
for p=1:Ccf_row
    C_Column=ones(Cdd_row,1);
    C_cf=zeros(1,C_come_column);
    C_cf=C_leave_dir(p,:);
    C_car=[];
    C_Car=[];
    C_car=C_Column*C_cf;
    C_Car=C_Car_information.*C_car;             %����������ǳ����г��������򣬸������г�Ϊ�ó����г�������������ŷ����ṩ���г�����
    
    C_fx=ones(1,C_come_column);
    C_time=zeros(C_time_nowoffer_row,1);
    C_time=C_time_nowoffer(:,p);
    C_ofer=[];
    C_reffer=[];
    C_ofer=C_time*C_fx;                         %�����������ʱ��Լ���������г�Ϊ�ó����г���ʱ���������
    C_reffer=C_ofer.*C_Car;                     %������ȿ���ʱ�����Լ�����ֿ����г�����Լ���������г�Ϊ�ó����г��ܹ��ṩ���г�����
    
    
    C_car_weight=[];
    C_reffer_weight=0;
    C_car_weight=C_Column*C_weight_direction_of_train;
    C_reffer_weight=C_reffer.*C_car_weight;
    
    C_reffer_num=0;
    C_reffer_num=sum(sum(C_reffer));
    
    C_reffer_weight_num=0;
    C_reffer_weight_num=sum(sum(C_reffer_weight));
    
    if (C_reffer_num>=C_leave_length_min(1,p))&&(C_reffer_weight_num<C_leave_weight_min(1,p))
        C_reffer_zhuanzhi=[];
        C_reffer_zhuanzhi=C_reffer.';           %ת������Ϊmatlab��find�����Ǵ��н������ģ���Ӧ����������Ϊ������������
        PL_succed_Number(1,PL_succed_num)=p;    %�����Ǹ��ݳ�������˳����䣬Ϊ�ˣ�������ת�ã�����find������ת�þ����������
        PL_succed(1,PL_succed_num)=Ccf(p,2);    %��Ӧ�ľ���ԭ������ĳ�������˳��
        PL_succed_car_xuhao_weight(1,PL_succed_num)=0;
        PL_succed_car_xuhao_number(1,PL_succed_num)=C_leave_length_min(1,p);
        C_PL_car=0;
        PL_succed_num=PL_succed_num+1;
        num_row=[];num_column=[];
        [num_row,num_column]=find(C_reffer_zhuanzhi>0);
        N_row=0;
        N_column=0;
        [N_row,N_column]=size(num_row);
        for i=N_row:-1:1                        %��N_row����ʼ������Ϊ��ϣ���������������ٱ���������ٷ�������о������г����䣬�����Ļ����ܿ���ǰ�漸�������г����ٷ���������޷����䳵��                       
            if (C_PL_car+C_reffer(num_column(i,1),num_row(i,1)))<C_leave_length_min(1,p)
                C_PL_car=C_PL_car+C_reffer(num_column(i,1),num_row(i,1));
                PL(PL_number,1)=Ccf(p,2);
                PL(PL_number,2)=Cdd(num_column(i,1),2);
                PL(PL_number,3)=Ccf(p,4);
                PL(PL_number,4)=Cdd(num_column(i,1),4);
                PL(PL_number,5)=num_row(i,1);
                PL(PL_number,6)=C_reffer(num_column(i,1),num_row(i,1));
                PL(PL_number,7)=C_weight_direction_of_train(1,num_row(i,1));
                PL_succed_car_xuhao_weight(1,PL_succed_num-1)=PL_succed_car_xuhao_weight(1,PL_succed_num-1)+PL(PL_number,6)*C_weight_direction_of_train(1,num_row(i,1));
                C_Car_information(num_column(i,1),num_row(i,1))=0;
                PL_number=PL_number+1;
            else
                C_PL_car_chazhi=C_PL_car+C_reffer(num_column(i,1),num_row(i,1))-C_leave_length_min(1,p);
                PL(PL_number,1)=Ccf(p,2);
                PL(PL_number,2)=Cdd(num_column(i,1),2);
                PL(PL_number,3)=Ccf(p,4);
                PL(PL_number,4)=Cdd(num_column(i,1),4);
                PL(PL_number,5)=num_row(i,1);
                PL(PL_number,6)=C_leave_length_min(1,p)-C_PL_car;
                PL(PL_number,7)=C_weight_direction_of_train(1,num_row(i,1));
                PL_succed_car_xuhao_weight(1,PL_succed_num-1)=PL_succed_car_xuhao_weight(1,PL_succed_num-1)+PL(PL_number,6)*C_weight_direction_of_train(1,num_row(i,1));
                C_Car_information(num_column(i,1),num_row(i,1))=C_PL_car_chazhi;
                PL_number=PL_number+1;
                break
            end
        end
    end
    
    if (C_reffer_num<C_leave_length_min(1,p))&&(C_reffer_weight_num>=C_leave_weight_min(1,p))
        C_reffer_zhuanzhi=[];
        C_reffer_zhuanzhi=C_reffer.';           %ת������Ϊmatlab��find�����Ǵ��н������ģ���Ӧ����������Ϊ������������
        PL_succed_Number(1,PL_succed_num)=p;    %�����Ǹ��ݳ�������˳����䣬Ϊ�ˣ�������ת�ã�����find������ת�þ����������
        PL_succed(1,PL_succed_num)=Ccf(p,2);    %��Ӧ�ľ���ԭ������ĳ�������˳��
        PL_succed_car_xuhao_weight(1,PL_succed_num)=0;
        PL_succed_car_xuhao_number(1,PL_succed_num)=0;
        PL_succed_num=PL_succed_num+1;
        C_PL_car=0;
        C_PL_car_weight=0;
        num_row=[];num_column=[];
        [num_row,num_column]=find(C_reffer_zhuanzhi>0);
        N_row=0;
        N_column=0;
        [N_row,N_column]=size(num_row);
        for i=N_row:-1:1                        %��N_row����ʼ������Ϊ��ϣ���������������ٱ���������ٷ�������о������г����䣬�����Ļ����ܿ���ǰ�漸�������г����ٷ���������޷����䳵��                       
            if (C_PL_car_weight+C_reffer(num_column(i,1),num_row(i,1))*C_weight_direction_of_train(1,num_row(i,1)))<C_leave_weight_min(1,p)
                C_PL_car=C_PL_car+C_reffer(num_column(i,1),num_row(i,1));
                C_PL_car_weight=C_PL_car_weight+C_reffer(num_column(i,1),num_row(i,1))*C_weight_direction_of_train(1,num_row(i,1));
                PL(PL_number,1)=Ccf(p,2);
                PL(PL_number,2)=Cdd(num_column(i,1),2);
                PL(PL_number,3)=Ccf(p,4);
                PL(PL_number,4)=Cdd(num_column(i,1),4);
                PL(PL_number,5)=num_row(i,1);
                PL(PL_number,6)=C_reffer(num_column(i,1),num_row(i,1));
                PL(PL_number,7)=C_weight_direction_of_train(1,num_row(i,1));
                
                PL_succed_car_xuhao_weight(1,PL_succed_num-1)=PL_succed_car_xuhao_weight(1,PL_succed_num-1)+PL(PL_number,6)*C_weight_direction_of_train(1,num_row(i,1));
                C_Car_information(num_column(i,1),num_row(i,1))=0;
                PL_number=PL_number+1;
            else
                C_PL_car_chazhi=C_reffer(num_column(i,1),num_row(i,1))-ceil((C_leave_weight_min(1,p)-C_PL_car_weight)/C_weight_direction_of_train(1,num_row(i,1)));
                C_PL_car=C_PL_car+ceil((C_leave_weight_min(1,p)-C_PL_car_weight)/C_weight_direction_of_train(1,num_row(i,1)));
                PL(PL_number,1)=Ccf(p,2);
                PL(PL_number,2)=Cdd(num_column(i,1),2);
                PL(PL_number,3)=Ccf(p,4);
                PL(PL_number,4)=Cdd(num_column(i,1),4);
                PL(PL_number,5)=num_row(i,1);
                PL(PL_number,6)=ceil((C_leave_weight_min(1,p)-C_PL_car_weight)/C_weight_direction_of_train(1,num_row(i,1)));
                PL(PL_number,7)=C_weight_direction_of_train(1,num_row(i,1));
                PL_succed_car_xuhao_weight(1,PL_succed_num-1)=PL_succed_car_xuhao_weight(1,PL_succed_num-1)+PL(PL_number,6)*C_weight_direction_of_train(1,num_row(i,1));
                PL_succed_car_xuhao_number(1,PL_succed_num-1)=C_PL_car;
                C_Car_information(num_column(i,1),num_row(i,1))=C_PL_car_chazhi;
                PL_number=PL_number+1;
                break
            end
        end
    end
    
    if (C_reffer_num>=C_leave_length_min(1,p))&&(C_reffer_weight_num>=C_leave_weight_min(1,p))
        C_reffer_zhuanzhi=[];
        C_reffer_zhuanzhi=C_reffer.';           %ת������Ϊmatlab��find�����Ǵ��н������ģ���Ӧ����������Ϊ������������
        PL_succed_Number(1,PL_succed_num)=p;    %�����Ǹ��ݳ�������˳����䣬Ϊ�ˣ�������ת�ã�����find������ת�þ����������
        PL_succed(1,PL_succed_num)=Ccf(p,2);    %��Ӧ�ľ���ԭ������ĳ�������˳��
        PL_succed_car_xuhao_weight(1,PL_succed_num)=0;
        PL_succed_car_xuhao_number(1,PL_succed_num)=0;
        PL_succed_num=PL_succed_num+1;
        C_PL_car=0;
        C_PL_car_weight=0;
        num_row=[];num_column=[];
        [num_row,num_column]=find(C_reffer_zhuanzhi>0);
        N_row=0;
        N_column=0;
        [N_row,N_column]=size(num_row);
        for i=N_row:-1:1                        %��N_row����ʼ������Ϊ��ϣ���������������ٱ���������ٷ�������о������г����䣬�����Ļ����ܿ���ǰ�漸�������г����ٷ���������޷����䳵��                       
            if ((C_PL_car+C_reffer(num_column(i,1),num_row(i,1)))<C_leave_length_min(1,p))&&((C_PL_car_weight+C_reffer(num_column(i,1),num_row(i,1))*C_weight_direction_of_train(1,num_row(i,1)))<C_leave_weight_min(1,p))
                C_PL_car=C_PL_car+C_reffer(num_column(i,1),num_row(i,1));
                C_PL_car_weight=C_PL_car_weight+C_reffer(num_column(i,1),num_row(i,1))*C_weight_direction_of_train(1,num_row(i,1));
                PL(PL_number,1)=Ccf(p,2);
                PL(PL_number,2)=Cdd(num_column(i,1),2);
                PL(PL_number,3)=Ccf(p,4);
                PL(PL_number,4)=Cdd(num_column(i,1),4);
                PL(PL_number,5)=num_row(i,1);
                PL(PL_number,6)=C_reffer(num_column(i,1),num_row(i,1));
                PL(PL_number,7)=C_weight_direction_of_train(1,num_row(i,1));
                
                PL_succed_car_xuhao_weight(1,PL_succed_num-1)=PL_succed_car_xuhao_weight(1,PL_succed_num-1)+PL(PL_number,6)*C_weight_direction_of_train(1,num_row(i,1));
                C_Car_information(num_column(i,1),num_row(i,1))=0;
                PL_number=PL_number+1;
            elseif ((C_PL_car+C_reffer(num_column(i,1),num_row(i,1)))>=C_leave_length_min(1,p))&&((C_PL_car_weight+C_reffer(num_column(i,1),num_row(i,1))*C_weight_direction_of_train(1,num_row(i,1)))<C_leave_weight_min(1,p))
                C_PL_car_chazhi=C_PL_car+C_reffer(num_column(i,1),num_row(i,1))-C_leave_length_min(1,p);
                PL(PL_number,1)=Ccf(p,2);
                PL(PL_number,2)=Cdd(num_column(i,1),2);
                PL(PL_number,3)=Ccf(p,4);
                PL(PL_number,4)=Cdd(num_column(i,1),4);
                PL(PL_number,5)=num_row(i,1);
                PL(PL_number,6)=C_leave_length_min(1,p)-C_PL_car;
                PL(PL_number,7)=C_weight_direction_of_train(1,num_row(i,1));
                PL_succed_car_xuhao_weight(1,PL_succed_num-1)=PL_succed_car_xuhao_weight(1,PL_succed_num-1)+PL(PL_number,6)*C_weight_direction_of_train(1,num_row(i,1));
                PL_succed_car_xuhao_number(1,PL_succed_num-1)=C_leave_length_min(1,p);
                C_Car_information(num_column(i,1),num_row(i,1))=C_PL_car_chazhi;
                PL_number=PL_number+1;
                break
            elseif ((C_PL_car+C_reffer(num_column(i,1),num_row(i,1)))<C_leave_length_min(1,p))&&((C_PL_car_weight+C_reffer(num_column(i,1),num_row(i,1))*C_weight_direction_of_train(1,num_row(i,1)))>=C_leave_weight_min(1,p))
                C_PL_car_chazhi=C_reffer(num_column(i,1),num_row(i,1))-ceil((C_leave_weight_min(1,p)-C_PL_car_weight)/C_weight_direction_of_train(1,num_row(i,1)));
                C_PL_car=C_PL_car+ceil((C_leave_weight_min(1,p)-C_PL_car_weight)/C_weight_direction_of_train(1,num_row(i,1)));
                PL(PL_number,1)=Ccf(p,2);
                PL(PL_number,2)=Cdd(num_column(i,1),2);
                PL(PL_number,3)=Ccf(p,4);
                PL(PL_number,4)=Cdd(num_column(i,1),4);
                PL(PL_number,5)=num_row(i,1);
                PL(PL_number,6)=ceil((C_leave_weight_min(1,p)-C_PL_car_weight)/C_weight_direction_of_train(1,num_row(i,1)));
                PL(PL_number,7)=C_weight_direction_of_train(1,num_row(i,1));
                PL_succed_car_xuhao_weight(1,PL_succed_num-1)=PL_succed_car_xuhao_weight(1,PL_succed_num-1)+PL(PL_number,6)*C_weight_direction_of_train(1,num_row(i,1));
                PL_succed_car_xuhao_number(1,PL_succed_num-1)=C_PL_car;
                C_Car_information(num_column(i,1),num_row(i,1))=C_PL_car_chazhi;
                PL_number=PL_number+1;
                break
            elseif((C_PL_car+C_reffer(num_column(i,1),num_row(i,1)))>=C_leave_length_min(1,p))&&((C_PL_car_weight+C_reffer(num_column(i,1),num_row(i,1))*C_weight_direction_of_train(1,num_row(i,1)))>=C_leave_weight_min(1,p))
                length_need=0;
                weight_need=0;
                min_need=0;
                length_need=C_leave_length_min(1,p)-C_PL_car;
                weight_need=ceil((C_leave_weight_min(1,p)-C_PL_car_weight)/C_weight_direction_of_train(1,num_row(i,1)));
                min_need=min(length_need,weight_need);
                C_PL_car=C_PL_car+min_need;
                PL(PL_number,1)=Ccf(p,2);
                PL(PL_number,2)=Cdd(num_column(i,1),2);
                PL(PL_number,3)=Ccf(p,4);
                PL(PL_number,4)=Cdd(num_column(i,1),4);
                PL(PL_number,5)=num_row(i,1);
                PL(PL_number,6)=min_need;
                PL(PL_number,7)=C_weight_direction_of_train(1,num_row(i,1));
                PL_succed_car_xuhao_weight(1,PL_succed_num-1)=PL_succed_car_xuhao_weight(1,PL_succed_num-1)+PL(PL_number,6)*C_weight_direction_of_train(1,num_row(i,1));
                PL_succed_car_xuhao_number(1,PL_succed_num-1)=C_PL_car;
                C_Car_information(num_column(i,1),num_row(i,1))=C_reffer(num_column(i,1),num_row(i,1))-PL(PL_number,6);
                PL_number=PL_number+1;
                break
            end
        end
    end
end


%%%���ж�������
[PL_succed_row,PL_succed_column]=size(PL_succed_Number);
%%%C_leave_length_max
for j=1:PL_succed_column
    C_Column=ones(Cdd_row,1);
    C_cf=zeros(1,C_come_column);
    C_cf=C_leave_dir(PL_succed_Number(1,j),:);
    C_car=[];
    C_Car=[];
    C_car=C_Column*C_cf;
    C_Car=C_Car_information.*C_car;             %����������ǳ����г��������򣬸������г�Ϊ�����г��ṩ���г�����
    C_fx=ones(1,C_come_column);
    C_time=zeros(C_time_nowoffer_row,1);
    C_time=C_time_nowoffer(:,PL_succed_Number(1,j));
    C_ofer=[];
    C_reffer=[];
    
    C_ofer=C_time*C_fx;                         %�����������ʱ��Լ���������г�Ϊ�ó����г���ʱ���������
    C_reffer=C_ofer.*C_Car;                     %������ȿ���ʱ�����Լ�����ֿ����г�����Լ���������г�Ϊ�ó����г��ܹ��ṩ���г�����
    
    C_car_weight=[];
    C_reffer_weight=0;
    C_car_weight=C_Column*C_weight_direction_of_train;
    C_reffer_weight=C_reffer.*C_car_weight;
    
    C_reffer_num=0;
    C_reffer_num=sum(sum(C_reffer));
    
    C_reffer_weight_num=0;
    C_reffer_weight_num=sum(sum(C_reffer_weight));
    
    if C_reffer_num>0
        C_reffer_zhuanzhi=[];
        C_reffer_zhuanzhi=C_reffer.';           %����ľ���ת�����һ��forѭ��ͬ��
        
        C_PL_car=PL_succed_car_xuhao_number(1,j);
        C_PL_car_weight=PL_succed_car_xuhao_weight(1,j);
        
        num_row=[];num_column=[];
        [num_row,num_column]=find(C_reffer_zhuanzhi>0);
        N_row=0;
        N_column=0;
        [N_row,N_column]=size(num_row);
        for i=1:N_row                           %�����1��ʼ��Ϊ��������С��������ĳ����г������յ���˳��Ϊ�䲹������
            if ((C_PL_car+C_reffer(num_column(i,1),num_row(i,1)))<C_leave_length_max(1,PL_succed_Number(1,j)))&&(((C_PL_car_weight+C_reffer(num_column(i,1),num_row(i,1))*C_weight_direction_of_train(1,num_row(i,1)))<C_leave_weight_max(1,PL_succed_Number(1,j))))      %Ŀǰ������45-55Ϊ�ˣ�����������ʱ���㽫�����ֵ���Ϊ10
                C_PL_car=C_PL_car+C_reffer(num_column(i,1),num_row(i,1));
                C_PL_car_weight=C_PL_car_weight+C_reffer(num_column(i,1),num_row(i,1))*C_weight_direction_of_train(1,num_row(i,1));
                PL(PL_number,1)=Ccf(PL_succed_Number(1,j),2);
                PL(PL_number,2)=Cdd(num_column(i,1),2);
                PL(PL_number,3)=Ccf(PL_succed_Number(1,j),4);
                PL(PL_number,4)=Cdd(num_column(i,1),4);
                PL(PL_number,5)=num_row(i,1);
                PL(PL_number,6)=C_reffer(num_column(i,1),num_row(i,1));
                PL(PL_number,7)=C_weight_direction_of_train(1,num_row(i,1));
                PL_succed_car_xuhao_weight(1,j)=PL_succed_car_xuhao_weight(1,j)+PL(PL_number,6)*C_weight_direction_of_train(1,num_row(i,1));
                PL_succed_car_xuhao_number(1,j)=PL_succed_car_xuhao_number(1,j)+C_reffer(num_column(i,1),num_row(i,1));
                C_Car_information(num_column(i,1),num_row(i,1))=0;
                PL_number=PL_number+1;
            elseif ((C_PL_car+C_reffer(num_column(i,1),num_row(i,1)))>=C_leave_length_max(1,PL_succed_Number(1,j)))&&(((C_PL_car_weight+C_reffer(num_column(i,1),num_row(i,1))*C_weight_direction_of_train(1,num_row(i,1)))<C_leave_weight_max(1,PL_succed_Number(1,j))))       
                C_PL_car_chazhi=C_PL_car+C_reffer(num_column(i,1),num_row(i,1))-C_leave_length_max(1,PL_succed_Number(1,j));
                PL(PL_number,1)=Ccf(PL_succed_Number(1,j),2);
                PL(PL_number,2)=Cdd(num_column(i,1),2);
                PL(PL_number,3)=Ccf(PL_succed_Number(1,j),4);
                PL(PL_number,4)=Cdd(num_column(i,1),4);
                PL(PL_number,5)=num_row(i,1);
                PL(PL_number,6)=C_leave_length_max(1,PL_succed_Number(1,j))-C_PL_car;
                PL(PL_number,7)=C_weight_direction_of_train(1,num_row(i,1));
                PL_succed_car_xuhao_weight(1,j)=PL_succed_car_xuhao_weight(1,j)+PL(PL_number,6)*C_weight_direction_of_train(1,num_row(i,1));
                PL_succed_car_xuhao_number(1,j)=PL_succed_car_xuhao_number(1,j)+PL(PL_number,6);
                C_Car_information(num_column(i,1),num_row(i,1))=C_PL_car_chazhi;
                PL_number=PL_number+1;
                break
            elseif ((C_PL_car+C_reffer(num_column(i,1),num_row(i,1)))<C_leave_length_max(1,PL_succed_Number(1,j)))&&(((C_PL_car_weight+C_reffer(num_column(i,1),num_row(i,1))*C_weight_direction_of_train(1,num_row(i,1)))>=C_leave_weight_max(1,PL_succed_Number(1,j))))
                C_PL_car_chazhi=C_reffer(num_column(i,1),num_row(i,1))-floor((C_leave_weight_max(1,PL_succed_Number(1,j))-C_PL_car_weight)/C_weight_direction_of_train(1,num_row(i,1)));
                if floor((C_leave_weight_max(1,PL_succed_Number(1,j))-C_PL_car_weight)/C_weight_direction_of_train(1,num_row(i,1)))>0
                    C_PL_car=C_PL_car+floor((C_leave_weight_max(1,PL_succed_Number(1,j))-C_PL_car_weight)/C_weight_direction_of_train(1,num_row(i,1)));
                    PL(PL_number,1)=Ccf(PL_succed_Number(1,j),2);
                    PL(PL_number,2)=Cdd(num_column(i,1),2);
                    PL(PL_number,3)=Ccf(PL_succed_Number(1,j),4);
                    PL(PL_number,4)=Cdd(num_column(i,1),4);
                    PL(PL_number,5)=num_row(i,1);
                    PL(PL_number,6)=floor((C_leave_weight_max(1,PL_succed_Number(1,j))-C_PL_car_weight)/C_weight_direction_of_train(1,num_row(i,1)));
                    PL(PL_number,7)=C_weight_direction_of_train(1,num_row(i,1));
                    PL_succed_car_xuhao_weight(1,j)=PL_succed_car_xuhao_weight(1,j)+PL(PL_number,6)*C_weight_direction_of_train(1,num_row(i,1));
                    PL_succed_car_xuhao_number(1,j)=PL_succed_car_xuhao_number(1,j)+PL(PL_number,6);
                    C_Car_information(num_column(i,1),num_row(i,1))=C_PL_car_chazhi;
                    PL_number=PL_number+1;
                    break
                else 
                    break
                end
            elseif ((C_PL_car+C_reffer(num_column(i,1),num_row(i,1)))>=C_leave_length_max(1,PL_succed_Number(1,j)))&&(((C_PL_car_weight+C_reffer(num_column(i,1),num_row(i,1))*C_weight_direction_of_train(1,num_row(i,1)))>=C_leave_weight_max(1,PL_succed_Number(1,j))))
                length_need=0;
                weight_need=0;
                min_need=0;
                length_need=C_leave_length_max(1,PL_succed_Number(1,j))-C_PL_car;
                weight_need=floor((C_leave_weight_max(1,p)-C_PL_car_weight)/C_weight_direction_of_train(1,num_row(i,1)));
                min_need=min(length_need,weight_need);
                if min_need>0
                    C_PL_car=C_PL_car+min_need;
                
                    PL(PL_number,1)=Ccf(PL_succed_Number(1,j),2);
                    PL(PL_number,2)=Cdd(num_column(i,1),2);
                    PL(PL_number,3)=Ccf(PL_succed_Number(1,j),4);
                    PL(PL_number,4)=Cdd(num_column(i,1),4);
                    PL(PL_number,5)=num_row(i,1);
                    PL(PL_number,6)=min_need;
                    PL(PL_number,7)=C_weight_direction_of_train(1,num_row(i,1));
                    PL_succed_car_xuhao_weight(1,j)=PL_succed_car_xuhao_weight(1,j)+PL(PL_number,6)*C_weight_direction_of_train(1,num_row(i,1));
                    PL_succed_car_xuhao_number(1,j)=PL_succed_car_xuhao_number(1,j)+PL(PL_number,6);
                    C_Car_information(num_column(i,1),num_row(i,1))=C_reffer(num_column(i,1),num_row(i,1))-PL(PL_number,6);
                    PL_number=PL_number+1;
                    break
                else
                    break
                end
            end
        end
    end
end
C_car_remain_row=[];
C_car_remain_column=[];
C_Car_information_zhuanzhi=[];
C_Car_information_zhuanzhi=C_Car_information.';    %ת�þ���Ϊ�˴ӵ����г�˳��Ƕȶ�����з���
[C_car_remain_row,C_car_remain_column]=find(C_Car_information_zhuanzhi>0);
C_Car_remain_row=0;
C_Car_remain_column=0;
[C_Car_remain_row,C_Car_remain_column]=size(C_car_remain_row);
for k=1:C_Car_remain_row                           %��1��ʼ���ǣ��ڽ����ٷ�������У������г�����˳�����
    PL(PL_number,1)=99999;
    PL(PL_number,2)=Cdd(C_car_remain_column(k,1),2);
    PL(PL_number,3)=Ccf(Ccf_row,4);
    PL(PL_number,4)=Cdd(C_car_remain_column(k,1),4);
    PL(PL_number,5)=C_car_remain_row(k,1);
    PL(PL_number,6)=C_Car_information(C_car_remain_column(k,1),C_car_remain_row(k,1));
    PL(PL_number,7)=C_weight_direction_of_train(1,C_car_remain_row(k,1));
    C_Car_information(C_car_remain_column(k,1),C_car_remain_row(k,1))=0;
    PL_number=PL_number+1;
end
PL=sortrows(PL,1);
T_car_remain_at_station=sum((PL(:,3)-PL(:,4)).*PL(:,6));

    
    