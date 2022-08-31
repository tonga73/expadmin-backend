import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { DistrictService } from './district.service';
import { District as DistrictModel } from '@prisma/client';

@Controller()
export class DistrictController {
  constructor(private readonly districtService: DistrictService) {}

  // OBTENER TODAS LAS CIRCUNSCRIPCIONES
  @Get('districts')
  async getDistricts(): Promise<DistrictModel[]> {
    return this.districtService.districts({});
  }

  // OBTENER LA CIRCUNSCRIPCION POR ID
  @Get('district/:id')
  async getDistrictById(@Param('id') id: string): Promise<DistrictModel> {
    return this.districtService.district({ id: Number(id) });
  }

  // CREAR CIRCUNSCRIPCION
  @Post('district')
  async newDistrict(
    @Body() districtData: { name: string; city?: string },
  ): Promise<DistrictModel> {
    return this.districtService.createDistrict(districtData);
  }
}
