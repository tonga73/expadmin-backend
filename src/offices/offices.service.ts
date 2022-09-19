import { Injectable } from '@nestjs/common';
import { CreateOfficeDto } from './dto/create-office.dto';
import { UpdateOfficeDto } from './dto/update-office.dto';

import { Office, Prisma } from '@prisma/client';
import { PrismaService } from '../prisma.service';

@Injectable()
export class OfficesService {
  constructor(private prisma: PrismaService) {}

  create(data: Prisma.OfficeCreateInput): Promise<Office> {
    return this.prisma.office.create({
      data,
    });
  }

  async findAll(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.OfficeWhereUniqueInput;
    where?: Prisma.OfficeWhereInput;
    orderBy?: Prisma.OfficeOrderByWithRelationInput;
  }): Promise<Office[]> {
    const { skip, take, cursor, where, orderBy } = params;
    return this.prisma.office.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
    });
  }

  findOne(
    officeWhereUniqueInput: Prisma.OfficeWhereUniqueInput,
  ): Promise<Office | null> {
    return this.prisma.office.findUnique({
      where: officeWhereUniqueInput,
      include: {
        court: true,
        records: true,
      },
    });
  }

  update(id: number, updateOfficeDto: UpdateOfficeDto): Promise<Office> {
    return this.prisma.office.update({
      data: updateOfficeDto,
      where: { id },
    });
  }

  remove(where: Prisma.OfficeWhereUniqueInput): Promise<Office> {
    return this.prisma.office.delete({
      where,
    });
  }
}
