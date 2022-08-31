import { Body, Controller, Get, Post } from '@nestjs/common';
import { DistrictService } from './district.service';
import { District as DistrictModel } from '@prisma/client';

@Controller()
export class DistrictController {
  constructor(private readonly districtService: DistrictService) {}

  // OBTENER TODAS LAS CIUDADES
  @Get('districts')
  async getDistricts(): Promise<DistrictModel[]> {
    return this.districtService.districts({});
  }

  // CREAR CIUDAD
  @Post('district')
  async newDistrict(
    @Body() districtData: { name: string; city?: string },
  ): Promise<DistrictModel> {
    return this.districtService.createDistrict(districtData);
  }
}
