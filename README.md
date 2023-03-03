# ZephStore-Skybox

## Kurulumu
**.smx** eklentisini `addons/sourcemod/plugins` dizesine yükleyiniz.
`addons/sourcemod/translations/store.phrases.txt` dosyasının son `}` öncesine altta vereceğim dili ekleyin.

	"Skybox"
	{
                "en" "skybox"
                "tr" "skybox"
	}

Eklenti kurulumu tamam sunucunuzu yeniden başlatmanız yeterli olacaktır.

## Markete Skybox Ekleme

        "Skybox"
        {
        	"Alacakaranlık"
            {
                "path" "cs_baggage_skybox_"
                "price" "200000"
                "type" "Skybox"
            }
            "Vietnam"
            {
            	"path" "vietnam"
                "flag" "a"
                "type" "Skybox"
            }
        }
