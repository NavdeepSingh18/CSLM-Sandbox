xmlport 50063 "Import Subjects"
{
    FieldSeparator = ',';
    Format = VariableText;
    schema
    {
        textelement(Root)
        {
            tableelement("Subject Master"; "Subject Master-CS")
            {
                XmlName = 'Subject';
                fieldelement(SubjectCode; "Subject Master".Code)
                {
                    MinOccurs = Zero;
                    FieldValidate = No;
                }
                fieldelement(Course; "Subject Master".Course)
                {
                    FieldValidate = No;
                }
                fieldelement(Description; "Subject Master".Description)
                {
                    FieldValidate = No;
                }
                fieldelement(SubjectType; "Subject Master"."Subject Type")
                {
                    FieldValidate = Yes;
                }
                fieldelement(SubjectClass; "Subject Master"."Subject Classification")
                {
                    FieldValidate = No;
                }
                fieldelement(Dim_1; "Subject Master"."Global Dimension 1 Code")
                {
                    FieldValidate = No;
                }
                fieldelement(Dim_2; "Subject Master"."Global Dimension 2 Code")
                {
                    FieldValidate = No;
                }
                fieldelement(Credit; "Subject Master".Credit)
                {
                    FieldValidate = No;
                }
                fieldelement(AcadYear; "Subject Master"."Academic Year")
                {
                    FieldValidate = No;
                }
                fieldelement(Sem; "Subject Master".Semester)
                {
                    FieldValidate = No;
                }
                fieldelement(Group; "Subject Master"."Subject Group")
                {
                    FieldValidate = No;
                }
                fieldelement(Level; "Subject Master".Level)
                {
                    FieldValidate = No;
                }
                fieldelement(LevelDescription; "Subject Master"."Level Description")
                {
                    FieldValidate = No;
                }
                fieldelement(CoreRotationGroup; "Subject Master"."Core Rotation Group")
                {
                    FieldValidate = No;
                }
                fieldelement(Examination; "Subject Master".Examination)
                {
                    FieldValidate = No;
                }
                fieldelement(Duration; "Subject Master".Duration)
                {
                    FieldValidate = No;
                }
                fieldelement(TypeofSubject; "Subject Master"."Type of Subject")
                {
                    FieldValidate = No;
                }

                trigger OnBeforeInsertRecord()
                begin
                    T := "Subject Master".Count();
                    W.OPEN('Importing Subjects.....\' + Text001Lbl + Text002Lbl);
                end;

                trigger OnAfterInsertRecord()
                begin
                    C := C + 1;
                    W.UPDATE(1, T);
                    W.UPDATE(2, C);
                end;
            }
        }
    }


    trigger OnPostXmlPort()
    begin
        MESSAGE('Import/Export Process Completed Sucessfully....');
    end;

    var
        W: Dialog;
        T: Integer;
        C: Integer;
        Text001Lbl: Label 'Count    #########1########\';
        Text002Lbl: Label 'Importing    #########2########\';
}

