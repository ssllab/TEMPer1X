//
//  SSLTEMPer1Controller.m
//  TEMPer1X
//
//  Created by Andrew Mannering on 27/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SSLTEMPer1Controller.h"
#import "hidapi.h"

@implementation SSLTEMPer1Controller

static int decode_raw_data(unsigned char *data)
{
    unsigned int rawtemp = (data[3] & 0xFF) + (data[2] << 8);
    return rawtemp;
}

/* Calibration adjustments */
/* See http://www.pitt-pladdy.com/blog/_20110824-191017_0100_TEMPer_under_Linux_perl_with_Cacti/ */
static float raw_to_c(int rawtemp)
{
    float temp_c = rawtemp * (125.0 / 32000.0);
    
    //        temper1_calibration cal = get_calibration(busport);
    //        temp_c = (temp_c * cal.scale) + cal.offset;
    return temp_c;
}

static float c_to_u(float deg_c, char unit)
{
    if (unit == 'F')
        return (deg_c * 1.8) + 32.0;
    else if (unit == 'K')
        return (deg_c + 273.15);
    else
        return deg_c;
}


- (float)getTemp
{
	int res;
	unsigned char buf[256];
	hid_device *handle;
    float temp_c = 0.0;
    
    
	struct hid_device_info *devs, *cur_dev;
	
	devs = hid_enumerate(0x0c45, 0x7401);
	cur_dev = devs;	
	while (cur_dev) {
		if (cur_dev->usage_page == 0xff00 && cur_dev->usage == 1)
		{
			break;		
		}
		cur_dev = cur_dev->next;
	}
    
	if ((cur_dev != NULL) && cur_dev->usage_page == (unsigned short)0xff00 && cur_dev->usage == 1)
	{
		// Set up the command buffer.
		memset(buf,0x00,sizeof(buf));
		buf[0] = 0x01;
		buf[1] = 0x81;
		
		handle = hid_open_path(cur_dev->path);
		if (!handle) {
//			return 1;
		}
		else {
            // Request state (cmd 0x80). The first byte is the report number (0x1).
            const static char cq_temperature[] = { 0x01, 0x80, 0x33, 0x01, 0x00, 0x00, 0x00, 0x00 };
            
            memcpy(buf, cq_temperature, 8);
            hid_write(handle, buf, 8);
            if (res >= 0) 
            {
                // Read requested state. hid_read() has been set to be
                // non-blocking by the call to hid_set_nonblocking() above.
                // This loop demonstrates the non-blocking nature of hid_read().
                res = 0;
                int l = 0;
                bzero(buf, sizeof(buf));
                while (res == 0) {
                    res = hid_read_timeout(handle, buf, sizeof(buf), 5000);

                    if (++l > 5) break;
                }
                
                temp_c = c_to_u(raw_to_c(decode_raw_data(buf)), 'C');
                
            }
            
            hid_close(handle);
        }
    }
	
	hid_free_enumeration(devs);
    
	/* Free static HIDAPI objects. */
	hid_exit();
    
	return temp_c;
    
}

@end
