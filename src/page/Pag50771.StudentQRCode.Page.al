page 50771 "Student QRCode"
{
    Caption = 'Student QRCode';
    // DeleteAllowed = false;
    // InsertAllowed = false;
    // LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Student Master-CS";

    layout
    {
        area(content)
        {
            field("Student QRCode"; Rec."Student QRCode")
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the QrCode of the Student, for example, a logo.';
            }
        }
    }

    actions
    {
        area(processing)
        {
            /*     action(TakePicture)
                 {
                     ApplicationArea = All;
                     Caption = 'Take';
                     Image = Camera;
                     Promoted = true;
                     PromotedOnly = true;
                     PromotedCategory = Process;
                     PromotedIsBig = true;
                     ToolTip = 'Activate the camera on the device.';
                     Visible = CameraAvailable;


                 }
                 action(ImportPicture)
                 {
                     ApplicationArea = All;
                     Caption = 'Import';
                     Image = Import;
                     ToolTip = 'Import a picture file.';



                 }*/
        }
    }
    var
    //  CameraAvailable: Boolean;

}

